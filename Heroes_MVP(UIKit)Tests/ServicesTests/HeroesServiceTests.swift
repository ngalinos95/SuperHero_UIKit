//
//  HeroesServiceTests.swift
//  Heroes_MVP(UIKit)Tests
//
//  Created by Nikos Galinos, Vodafone on 10/7/23.
//  UnitTest of the service without using mocking for the service

import XCTest
@testable import Heroes_MVP_UIKit_
import PromiseKit


class HeroesServiceTests: XCTestCase {
    var heroesService: HeroesServiceProtocol!
    
    override func setUp() {
        super.setUp()
        //Given
        heroesService = HeroesService()
    }
    
    override func tearDown() {
        heroesService = nil
        super.tearDown()
    }
    
    func testGetSuperHeroSuccess() {
        let expectation = XCTestExpectation(description: "Get superhero expectation")

        //Given
        let id = "123" // A valid superhero ID for testing
        //When
        let promise = heroesService.getSuperHero(id: id)
       
        expectation.fulfill()

        //Then
        XCTAssertNotNil(promise, "Promise should not be nil")
                
        promise.done { superhero in
            //Then
            XCTAssertNotNil(superhero, "Superhero should not be nil")
        }.catch { error in
            //Then
            XCTFail("Error occurred: \(error)")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 12.0) // Adjust timeout as needed
    }
    
    func testGetSuperHeroFailure() {
        let expectation = XCTestExpectation(description: "Get superhero expectation")

        //Given
        let invalidId = "800" //An invalid hero id for testing the failure
        //When
        let promise = heroesService.getSuperHero(id: invalidId)
        expectation.fulfill()
        //Then
        
        
        promise.done { superhero in
            //Then
            XCTFail("Promise should have been rejected, if it passes and doesnt catch the error make sures it fails")
        }.catch { error in
            //Then
            XCTAssertNotNil(error, "Error should not be nil")
        }
        
        wait(for: [expectation], timeout: 12.0) // Adjust timeout
    }
}
