//
//  HeroesTableRxViewController.swift
//  Heroes_MVP(UIKit)
//
//  Created by Nikos Galinos on 28/8/23.
//

import UIKit
import RxCocoa
import RxSwift

class HeroesTableRxViewController: UIViewController, UISearchResultsUpdating {
    var onCompletion: (() -> Void)?
    // added the presenter DIable in order to be injected for testing puproses
    // We inkect the presenter with the real service and not the Mock one
    // When we try to unit test the cobtroller we can initialize it with a presentr with a mockHeroesService
    private let presenter: HeroTableRxPresenter!
    init(presenter: HeroTableRxPresenter! = HeroTableRxPresenter()) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    // Implement the required init?(coder aDecoder: NSCoder) initializer
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // We create a dispose bag for the RxSwift implementation
    private var bag = DisposeBag()
    // We create a new array to store the filtered heroes
    private var filteredHeroes = PublishSubject<[SuperHero]>()
    // We create the heroes array in which we are going to pass the fetchData
    var heroes: [SuperHero] = [] {
        didSet {
            filteredHeroes.onNext(self.heroes)
        }
    }
    // MARK: - UI
    lazy var tableVw: UITableView = {
        let tableVw = UITableView(frame: CGRect.zero, style: .insetGrouped)
        tableVw.translatesAutoresizingMaskIntoConstraints = false
        tableVw.backgroundColor = .clear
        tableVw.rowHeight = UITableView.automaticDimension
        tableVw.estimatedRowHeight = 20 // minimum row Height
        tableVw.separatorStyle = .singleLine
        tableVw.register(HeroesTableRxViewCell.self, forCellReuseIdentifier: HeroesTableRxViewCell.cellId)
        tableVw.layer.cornerRadius = 20
        tableVw.layer.masksToBounds = true
        return tableVw
    }()
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        // add parameters for the controller
        // 1
        searchController.searchResultsUpdater = self
        // 2
        searchController.obscuresBackgroundDuringPresentation = false
        // 3
        searchController.searchBar.placeholder = "Search Heroes"
        // 4
        definesPresentationContext = true
        return searchController
    }()
    // MARK: - LifyCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bindTableData()
        setup()

    }
    // We create a bind function to connect the PublishedSubject of the Presenter
    // with the the ViewController
    // We are telling the UI that this data is related to the UI and when it changes update the UI
    // Thats the concept of the Reactive programming with RxSwift
    func bindTableData() {
        // FetchData via the presenter
        presenter.fetchData()
        // Bind heroes from the viewController to the superheroes from the presenter
        presenter.superHeroes.bind { [weak self] superHeroList in
            self?.heroes = superHeroList
            // Update your UI here if needed
        }.disposed(by: bag)
        // Bind superHeroes from the presenter to the tableVw
        self.filteredHeroes.bind(
            to: tableVw.rx.items(
                cellIdentifier: HeroesTableRxViewCell.cellId,
                cellType: HeroesTableRxViewCell.self)
            // swiftlint:disable:next unused_closure_parameter
        ) { row, model, cell in
            cell.configure(heroName: model.name)
        }.disposed(by: bag)
        // Bind a model selected handler
        tableVw.rx.modelSelected(SuperHero.self).bind { heroSelected in
            let infoViewController = InfoViewController()
            infoViewController.hero = heroSelected
            // on th tap push the new view controller
            self.navigationController?.pushViewController(infoViewController, animated: true)
        }.disposed(by: bag)
    }
    // updateSearchResults -> holds the logic on updating the filteredHeroed array based on the searchText
    func updateSearchResults (for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }
        if searchText.isEmpty {
            // If search text is empty, show all heroes
            filteredHeroes.onNext(self.heroes)
        } else {
            // Filter the heroes array based on the search text
            filteredHeroes.onNext(self.heroes.filter { $0.name.lowercased().contains(searchText.lowercased()) })
        }
    }
    // MARK: - Setup
    // We create a setup function to create the UI -> used on viewDidLoad
    func setup () {
        // add the navigation bar title
        self.navigationController?.navigationBar.topItem?.title = "Heroes"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        // add the search bar
        self.navigationItem.searchController = searchController
        // add view
        self.view.backgroundColor = .systemGroupedBackground
        self.view.addSubview(tableVw)
        // add our constraints to pin the tableview on the screen. self.view is a UIView which
        // every UIViewController has
        NSLayoutConstraint.activate([
            tableVw.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableVw.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableVw.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            tableVw.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }
}
