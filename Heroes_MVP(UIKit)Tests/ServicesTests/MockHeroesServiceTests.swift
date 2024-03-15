//
//  MockHeroesServiceTests.swift
//  Heroes_MVP(UIKit)Tests
//
//  Created by Nikos Galinos,   on 12/7/23.
//

import XCTest
@testable import Heroes_MVP_UIKit_
import PromiseKit

class MockHeroesServiceTests: XCTestCase {
    var superHeroTest: SuperHero?
    var catchError = false
    let mockURLSession = MockURLSession()
    var expectedSuperhero: SuperHero!
    var service: HeroesService!
    var expectation: XCTestExpectation!

    override func setUp() {
        super.setUp()
        
        // Prepare mock session
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
        mockURLSession.responseData = responseData
        
        // Create HeroesService with the mock session
        service = HeroesService(session: mockURLSession)
        
        // Set up expectation
        expectation = XCTestExpectation(description: "Get SuperHero")
        
        // Initialize the expected superhero directly here
        expectedSuperhero = try! JSONDecoder().decode(SuperHero.self, from: responseData!)
    }

    override func tearDown() {
        super.tearDown()
        
        superHeroTest = nil
        catchError = false
        service = nil
        expectation = nil
    }

    func testGetSuperHero() throws {
        // Perform the request
        service.getSuperHero(id: "1").done { superhero in
            // Fulfill the expectation
            self.expectation.fulfill()
            self.superHeroTest = superhero
        }.catch { error in
            // Fail the test in case of an error
            self.catchError = true
        }

        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 10.0)

        XCTAssertEqual(expectedSuperhero, superHeroTest)
        XCTAssertFalse(catchError)
    }
}
