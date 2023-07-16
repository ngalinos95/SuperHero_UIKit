//
//  HeroresTablePresenterTests.swift
//  Heroes_MVP(UIKit)Tests
//
//  Created by Nikos Galinos, Vodafone on 11/7/23.
//

import XCTest
@testable import Heroes_MVP_UIKit_
import PromiseKit


class MockHeroPresentersDelegate : HeroesPresenterDelegate {
    
    var presenHeroInput : [Heroes_MVP_UIKit_.SuperHero]!
    var expectation : XCTestExpectation!
    func presentHero(hero: [Heroes_MVP_UIKit_.SuperHero]) {
        presenHeroInput = hero
        expectation.fulfill()
    }
    
    
}

final class HeroresTablePresenterTests: XCTestCase  {
    
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
        
        let expectation = XCTestExpectation(description: "Get fetchdata expectation")
        //Given
        let mockDelegate = MockHeroPresentersDelegate() // initiate the mockDelegate
        
        mockDelegate.expectation = expectation //Set the expectation to the delegate

        presenter.delegate = mockDelegate // !!! we connect the Presenter with the MockDeleagte
        //When
        presenter.fetchData() // when call the fetch data the presenter runs the promises closure
        //the data flow from the presenter goes to the mockup delegate 
        
        wait(for: [expectation], timeout: 10.0) // Adjust timeout as needed
        
        //Then
        XCTAssertEqual(mockDelegate.presenHeroInput.count, 100)
  
    }
    
}


