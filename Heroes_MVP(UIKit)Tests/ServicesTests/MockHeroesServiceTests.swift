//
//  MockHeroesServiceTests.swift
//  Heroes_MVP(UIKit)Tests
//
//  Created by Nikos Galinos, Vodafone on 12/7/23.
//

import XCTest
@testable import Heroes_MVP_UIKit_
import PromiseKit

class MockHeroesServiceTests: XCTestCase {
    func testGetSuperHero()throws {
        // Prepare mock session
        //Given
        var superHeroTest : SuperHero?
        var catchError = false
        let mockURLSession = MockURLSession()
        let responseData = """
            {
                "id": "1",
                "name": "Superman",
                "image": {
                    "url": "https://example.com/superman.jpg"
                },
                "biography": {
                    "full-name": "Clark Kent",
                    "alter-egos": "Kal-El",
                    "aliases": ["Man of Steel", "The Last Son of Krypton"],
                    "place-of-birth": "Krypton",
                    "first-appearance": "Action Comics #1",
                    "publisher": "DC Comics",
                    "alignment": "good"
                },
                "powerstats": {
                    "intelligence": "100",
                    "strength": "100",
                    "speed": "100",
                    "durability": "100",
                    "power": "100",
                    "combat": "100"
                }
            }
            """.data(using: .utf8)
        let expectedSuperhero = try JSONDecoder().decode(SuperHero.self, from: responseData!)
        mockURLSession.responseData = responseData
        
        // Create HeroesService with the mock session
        let service = HeroesService(session: mockURLSession)
        
        // Set up expectation
        let expectation = XCTestExpectation(description: "Get SuperHero")
        
        // Perform the request
        service.getSuperHero(id: "1").done { superhero in
            // Fulfill the expectation
            expectation.fulfill()
            superHeroTest = superhero
            
        }.catch { error in
            // Fail the test in case of an error
            catchError = true
        }
        
        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 10.0)
        
        XCTAssertEqual(expectedSuperhero, superHeroTest)
        XCTAssertFalse(catchError)
    }
}

