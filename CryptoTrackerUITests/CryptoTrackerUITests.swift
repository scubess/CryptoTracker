//
//  CryptoTrackerUITests.swift
//  CryptoTrackerUITests
//
//  Created by selvaganapathy chinnakalai on 10/05/2025.
//

import XCTest

final class CryptoTrackerUITests: XCTestCase {

    func test_cryptoListLoadsAndDisplays() throws {
        let app = XCUIApplication()
        app.launch()

        let listExists = app.navigationBars["Cryptos"].waitForExistence(timeout: 2)
        XCTAssertTrue(listExists)

        // Optional: Assert at least one cell loads
        let firstCell = app.cells.firstMatch
        XCTAssertTrue(firstCell.waitForExistence(timeout: 2))
    }
}
