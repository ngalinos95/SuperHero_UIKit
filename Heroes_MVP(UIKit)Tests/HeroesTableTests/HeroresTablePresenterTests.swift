//
//  HeroresTablePresenterTests.swift
//  Heroes_MVP(UIKit)Tests
//
//  Created by Nikos Galinos, Vodafone on 11/7/23.
//

import XCTest
@testable import Heroes_MVP_UIKit_
import PromiseKit

// CREATE NEW CHANGES
final class HeroresTablePresenterTests: XCTestCase, HeroesPresenterDelegate {
    var presentHeroInput : [SuperHero]!
    
    func presentHero(hero: [Heroes_MVP_UIKit_.SuperHero]) {
        self.presentHeroInput = hero
        expectation.fulfill()
    }
    
    
    let expectation = XCTestExpectation(description: "Get fetchdata expectation")

    var presenter : HeroTablePresenter!
    
    override func setUp() {
        super.setUp()
        //Given
        //We inject the mockService
        presenter = HeroTablePresenter(heroesService: MockHeroesService())
        
    }
    override func tearDown() {
        presenter = nil
        super.tearDown()
        
    }
    
    func testFetchData() {
        
        

        presenter.delegate = self // !!! we connect the Presenter with the PresenterTest
        //When
        presenter.fetchData() // when call the fetch data the presenter runs the promises closure
        //the data flow from the presenter goes to the mockup delegate 
        
        wait(for: [expectation], timeout: 10.0) // Adjust timeout as needed
        
        //Then
        XCTAssertEqual(self.presentHeroInput.count, 100)
  
    }
    
}


