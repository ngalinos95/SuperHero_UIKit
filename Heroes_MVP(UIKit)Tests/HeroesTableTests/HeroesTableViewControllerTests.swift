//
//  HeroesTableViewControllerTests.swift
//  Heroes_MVP(UIKit)Tests
//
//  Created by Nikos Galinos,   on 19/7/23.
//

import XCTest
import SnapshotTesting
@testable import Heroes_MVP_UIKit_



final class HeroesTableViewControllerTests: XCTestCase , HeroesPresenterDelegate{
    let expectation = XCTestExpectation(description: "Get fetchdata expectation")
    //we track the completion of the fetching through the delegate function
    var presentHeroInput : [SuperHero]!
    func presentHero(hero: [Heroes_MVP_UIKit_.SuperHero]) {
        self.presentHeroInput = hero
        expectation.fulfill()
    }
    // Our sut : System Under Test
    var vc: HeroesTableViewController!
    var presenter : HeroTablePresenter!
   
    override func setUp () {
        // Given
        presenter = HeroTablePresenter(heroesService: MockHeroesService())
        vc = HeroesTableViewController(presenter: presenter)
    }
    
    override func tearDown () {
        presenter = nil
        vc = nil
    }
    
    func testDefaultState () {
        //Given
        presenter.delegate = self // !!! we connect the Presenter with the ViewCobtroller test
        //When
        presenter.fetchData() // when we call the fetch data the presenter runs the promises closure
        //the data flow from the presenter goes to the delegate
        wait(for: [expectation], timeout: 10.0) // Adjust timeout as needed
        vc.heroes = presentHeroInput
        assertSnapshot(matching: vc, as: .image)
    }
}
