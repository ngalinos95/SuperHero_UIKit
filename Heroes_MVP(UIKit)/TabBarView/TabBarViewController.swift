//
//  TabBarViewController.swift
//  Heroes_MVP(UIKit)
//
//  Created by Nikos Galinos, Vodafone on 5/7/23.
//

import UIKit

class TabBarViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Setup
    
    func setup(){
        //initiate all the view controllers of the tab bar interface
        let heroesTableViewController = UINavigationController(rootViewController:HeroesTableViewController())
        let appInfoViewController = UINavigationController(rootViewController: AppInfoVIewController())
        
        //set the title of each tab
        
        heroesTableViewController.title = "List"
        appInfoViewController.title = "Info"
        
        // Create the tab bar -> we present it at the end after all the setup
        
        let tabBarViewController = UITabBarController ()
        
        // Customize the appearance of the tab bar
        
        tabBarViewController.tabBar.tintColor = UIColor.systemBlue // Set the selected item color
        tabBarViewController.tabBar.unselectedItemTintColor = UIColor.gray // Set the unselected item color
        tabBarViewController.modalPresentationStyle = .fullScreen
        
        
        //set the view controllers to the tab bar
        tabBarViewController.setViewControllers([heroesTableViewController,appInfoViewController], animated: false)
        
        // Set the images
        if let items = tabBarViewController.tabBar.items {
            items[0].image = UIImage(systemName: "star")
            items[1].image = UIImage(systemName:"gear")
            
        }
       
           // Present the tab bar view controller onto the navigation stack
        present(tabBarViewController,animated: true)
       }
       
       
   }
