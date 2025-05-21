//
//  CryptoTrackerUITests.swift
//  CryptoTrackerUITests
//
//  Created by selvaganapathy chinnakalai on 10/05/2025.
//

import XCTest

class CryptoTrackerUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }

    func testCryptoListLoadsAndNavigatesToDetail() {
        // Wait for the table to appear
        let tableView = app.tables.element(boundBy: 0)
        XCTAssertTrue(tableView.waitForExistence(timeout: 5), "Crypto list table should exist")

        // Ensure there's at least one cell
        let firstCell = tableView.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists, "There should be at least one crypto cell")

        // Tap the first cell
        firstCell.tap()

        // Wait for detail view to appear
        let detailLabel = app.staticTexts.element(boundBy: 1)
        XCTAssertTrue(detailLabel.waitForExistence(timeout: 5), "Detail view should appear")

        // (Optional) Assert on known label content format like "Current Price: $..."
        let priceLabel = app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH 'Current Price'")).firstMatch
        XCTAssertTrue(priceLabel.exists, "Price label should be visible on detail screen")
    }
}
