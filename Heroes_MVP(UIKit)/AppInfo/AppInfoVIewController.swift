//
//  AppInfoVIewController.swift
//  Heroes_MVP(UIKit)
//
//  Created by Nikos Galinos,   on 6/7/23.
//

import UIKit
// MARK: - Outlets connection

class AppInfoVIewController: UIViewController {
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollContainerView: UIView!
    @IBOutlet weak var appInfoLabel: UILabel!
    @IBOutlet weak var descriptionTitle: UILabel!
    @IBOutlet weak var descritionLabel: UILabel!
    @IBOutlet weak var technologiesTitle: UILabel!
    @IBOutlet weak var technologiesLabel: UILabel!
    // MARK: - LifyCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        // Do any additional setup after loading the view.
    }
    // MARK: - Configure
    func configure() {
        appInfoLabel.text = "App Info"
        descriptionTitle.text = "Description"
        descritionLabel.text = """
        This app is a project on the Discover Graduate
        program aiming to learn new technologies on the iOS
        Development platform and practices used on the MVA app
        The app is still in development trying to implement
        new features that cover many topics on Swift using
        clean code practices and focusing on good User
        Experience.
        Check the List tab to see all the Heroes!
        """
        technologiesTitle.text = "Technologies"
        technologiesLabel.text = """
        The main technologies used are
        -> MVP Design Pattern
        -> PromiseKit for the asychronous call of the API
        -> UISearch for the list search bar
        -> Programmatically and non declaration of the UI
        -> UIKIt as the framework of choice for the UI Build
        -> TabBarController for the creation of tabbed UI
        -> TableController  for the creation of a  List
        -> UIScroll for the creation of a scrollable UI
        -> Protocols and Delegates
        -> Unit Tests
        """
    }
}
