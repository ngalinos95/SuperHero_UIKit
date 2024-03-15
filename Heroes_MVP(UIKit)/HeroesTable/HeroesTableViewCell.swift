//
//  HeroesTableViewCell.swift
//  Heroes_MVP(UIKit)
//
//  Created by Nikos Galinos,   on 22/6/23.
//

import UIKit
class HeroesTableViewCell: UITableViewCell {
    static let cellId = "HeroesTableViewCell" // we need an id for the cell we are creating
    // MARK: - UI
    // create the container of the cell
    lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    // create the Horizontal Stack
    lazy var nameStack: UIStackView = {
        let contentStack = UIStackView()
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .horizontal
        contentStack.spacing = 4
        return contentStack
    }()
    // create the text label
    private lazy var heroLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1 // let us create many number of line if we didnt have it ,it would present only 1 line
        lbl.font = .systemFont(ofSize: 16, weight: .medium)
        lbl.textColor = .black
        return lbl
    }()
    // MARK: - LifyCycle
    // MARK: - Configure
    func configure (heroName: String) {
        // add data
        containerView.backgroundColor = .white
        heroLabel.text = "\(heroName)"
        // addViews
        self.contentView.addSubview(containerView)
        containerView.addSubview(nameStack)
        // add the horizontal stack view label
        nameStack.addArrangedSubview(heroLabel)
        // add constrains
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 3),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -3),
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 3),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -3),
            nameStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            nameStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            nameStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            nameStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10)
        ])
    }
}
