//
//  TestViewController.swift
//  Heroes_MVP(UIKit)
//
//  Created by Nikos Galinos, Vodafone on 7/7/23.
//
//This is a test View Controller in order to test the ability to create a seperate UIView with IB (.xib file)
import UIKit

class TestViewController: UIViewController {
    
    var testView = TestView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
    
    
    
    
    func setup()  {
        
        //add the navigation Bar data
        
        
        //add the view in the controller
        testView.translatesAutoresizingMaskIntoConstraints = false
        self.testView.configure(label: "Hello World")
        //have to check if i have to unwrap hero
        self.view.addSubview(testView)
        
        //add the condtrains of the testView regarding the self.view and the controller
        NSLayoutConstraint.activate([
            testView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            testView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            testView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            testView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            testView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
        
        
    }
    
    
}
