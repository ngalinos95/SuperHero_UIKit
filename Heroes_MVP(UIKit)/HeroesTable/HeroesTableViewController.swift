//
//  HeroesTableViewController.swift
//  Heroes_MVP(UIKit)
//
//  Created by Nikos Galinos, Vodafone on 22/6/23.
//

import UIKit

class HeroesTableViewController: UIViewController, HeroesPresenterDelegate ,UISearchResultsUpdating {
    
    //added the presenter DIable in order to be injected for testing puproses
    //We inkect the presenter with the real service and not the Mock one
    private let presenter = HeroTablePresenter()
    
    private var filteredHeroes: [SuperHero] = [] //we create a new array to store the filtered heroes
    
    
    private var heroes: [SuperHero] = [] {
        didSet {
            filteredHeroes = heroes // Set the initial filteredHeroes array
        }
    }
   
    //MARK: - UI
    lazy var tableVw : UITableView = {
        let tableVw = UITableView(frame: CGRect.zero, style: .insetGrouped)
        tableVw.translatesAutoresizingMaskIntoConstraints = false
        tableVw.backgroundColor = .clear
        tableVw.rowHeight = UITableView.automaticDimension
        tableVw.estimatedRowHeight = 20 //minimum row Height
        tableVw.separatorStyle = .singleLine
        tableVw.register(HeroesTableViewCell.self, forCellReuseIdentifier: HeroesTableViewCell.cellId)
        tableVw.layer.cornerRadius = 20
        tableVw.layer.masksToBounds = true
        
        return tableVw
        
    }()
    
    lazy var searchController : UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        //add parameters for the controller
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
    
    
    //MARK: - LifyCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGroupedBackground
        // Do any additional setup after loading the view.
        setup()
        tableVw.delegate = self
        //Search Controller
        
        //Presenter
        presenter.delegate = self // !!! we connect the Presenter with the ViewController
        presenter.fetchData()
    }
    
    //Presenter Delegate
    //connects the viewcontroller with the presenter
    func presentHero(hero: [SuperHero]) {
        self.heroes=hero
        self.tableVw.reloadData()
        
    }
    
    // updateSearchResults -> holds the logic on updating the filteredHeroed array based on the searchText
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }
        
        if searchText.isEmpty {
            // If search text is empty, show all heroes
            filteredHeroes = heroes
        } else {
            // Filter the heroes array based on the search text
            filteredHeroes = heroes.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
        
        // Reload the table view data with the filtered results
        
        self.tableVw.reloadData()
        
        
        
    }
    
    
    
    //MARK: - Setup
    func setup(){
        // add the navigation bar title
        self.navigationController?.navigationBar.topItem?.title = "Heroes"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        //add the search bar
        self.navigationItem.searchController = searchController
        
        
        
        
        //data
        tableVw.dataSource = self //we need to implement the protocol functions of this delegate
        
        //add view
        self.view.addSubview(tableVw)
        
        // add our constraints to pin the tableview on the same position on the screen
        NSLayoutConstraint.activate([
            tableVw.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableVw.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableVw.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: 10),
            tableVw.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,constant: -10),
            
        ])
    }
    
    
    
}

//MARK: - DataSource, Delegate

extension HeroesTableViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredHeroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableVw.dequeueReusableCell(withIdentifier: HeroesTableViewCell.cellId, for: indexPath) as!HeroesTableViewCell
        cell.configure(heroName: self.filteredHeroes[indexPath.row].name)
        return cell
    }
    
    
    
    
}

extension HeroesTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableVw.deselectRow(at: indexPath, animated: true)
        
        let infoViewController = InfoViewController()
        let selectedHero = self.filteredHeroes[indexPath.row]
        infoViewController.hero = selectedHero
        //on th tap push the new view controller
        navigationController?.pushViewController(infoViewController, animated: true)
    }
}



