//
//  AppInfoViewControllerTests.swift
//  Heroes_MVP(UIKit)Tests
//
//  Created by Nikos Galinos, Vodafone on 10/7/23.
//
import XCTest
import SnapshotTesting
@testable import Heroes_MVP_UIKit_

class AppInfoViewControllerTests: XCTestCase {
    // Our sut : System Under Test
    var vc: AppInfoVIewController!

    override func setUp() {
        vc = AppInfoVIewController()
    }
    
    override func tearDown() {
        vc = nil
    }
    
    func testAppInfoDefaultState() {
        assertSnapshot(matching: vc, as: .image)
    }

}
