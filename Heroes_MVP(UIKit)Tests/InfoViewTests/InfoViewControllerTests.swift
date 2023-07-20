//
//  InfoViewControllerTests.swift
//  Heroes_MVP(UIKit)Tests
//
//  Created by Nikos Galinos, Vodafone on 19/7/23.
//

import XCTest
import SnapshotTesting
@testable import Heroes_MVP_UIKit_



class MockImageView: UIImageView {
    var mockImage: UIImage?
}

 class InfoViewControllerTests: XCTestCase {
    var vc: InfoViewController!
    var mockHero: SuperHero!
    var systemImage: UIImage!
    
    override func setUp() {
        let mockHero =
        SuperHero(id: "1", name: "Boom-Boom",
                  image: Image(url: "https://www.superherodb.com/pictures2/portraits/10/100/400.jpg"),
                  biography: Bio(fullName: "Tabitha Smith", alterEgos: "Meltdown", aliases: [
                    "Time Bomb",
                    "Boomer",
                    "Meltdown",
                    "Tabby",
                    "Firecracker",
                    "Mutate #35",
                    "Nancy Forrester"
                  ], placeOfBirth: "-", firstAppearance: "Secret Wars II #5",
                                 publisher: "Meltdown", alignment: "good"),
                  powerstats: Powerstats(intelligence: "38",
                                         strength: "10",
                                         speed: "12", durability: "42", power: "57", combat: "64"))
        vc = InfoViewController()
        // Trigger the loading of the view to establish IBOutlet connections
        vc.loadViewIfNeeded()
        // I'm mocking the hero
        vc.hero = mockHero
        // Mock the image to avoid the asynchronous call
        systemImage = UIImage(systemName: "star")
        vc.heroImageView.image = systemImage
        
        // Call configure() to update the UI with the mock image
        vc.configure()
        
    }
    
    override func tearDown() {
        mockHero = nil
        vc = nil
        systemImage = nil
    }
    
    func testInfoViewDefaultState() {
        

  
        // After the image is loaded, take the snapshot
        assertSnapshot(matching: vc, as: .image)
    }
}

