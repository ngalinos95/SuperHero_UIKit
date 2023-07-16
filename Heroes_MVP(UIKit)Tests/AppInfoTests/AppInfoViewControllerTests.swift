//
//  AppInfoViewControllerTests.swift
//  Heroes_MVP(UIKit)Tests
//
//  Created by Nikos Galinos, Vodafone on 10/7/23.
//
import XCTest
@testable import Heroes_MVP_UIKit_

class AppInfoViewControllerTests: XCTestCase {
    
    var viewController: AppInfoVIewController!
    
    override func setUp() {
        super.setUp()
        // Given
        viewController = AppInfoVIewController()
        viewController.loadViewIfNeeded()
    }
    
    override func tearDown() {
        // Given
        viewController = nil
        super.tearDown()
    }
    
    func testAppInfoLabelText() {
        // Given
        let expectedText = "App Info"
        
        // When
        let labelText = viewController.appInfoLabel.text
        
        // Then
        XCTAssertEqual(labelText, expectedText)
    }
    
    func testDescriptionTitleText() {
        // Given
        let expectedText = "Description"
        
        // When
        let labelText = viewController.descriptionTitle.text
        
        // Then
        XCTAssertEqual(labelText, expectedText)
    }
    
    func testDescriptionLabelText() {
        // Given
        let expectedText = """
        This app is a project on the Discover Graduate
        program aiming to learn new technologies on the iOS
        Development platform and practices used on the MVA app
        The app is still in development trying to implement
        new features that cover many topics on Swift using
        clean code practices and focusing on good User
        Experience.
        
        Check the List tab to see all the Heroes!
        """
        
        // When
        let labelContent = viewController.descritionLabel.text
        
        // Then
        XCTAssertEqual(labelContent, expectedText)
    }
    
    func testTechnologiesTitleText() {
        // Given
        let expectedText = "Technologies"
        
        // When
        let labelText = viewController.technologiesTitle.text
        
        // Then
        XCTAssertEqual(labelText, expectedText)
    }
    
    func testTechnologiesLabelContent() {
        // Given
        let expectedText = """
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
        
        // When
        let labelContent = viewController.technologiesLabel.text
        
        // Then
        XCTAssertEqual(labelContent, expectedText)
    }
}
