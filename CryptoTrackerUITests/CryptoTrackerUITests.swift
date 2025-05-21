//
//  CryptoTrackerUITests.swift
//  CryptoTrackerUITests
//
//  Created by selvaganapathy chinnakalai on 10/05/2025.
//

import XCTest

final class CryptoTrackerUITests: XCTestCase {

    func test_listLoadsAndDisplays() {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.navigationBars["Cryptos"].waitForExistence(timeout: 2))

        let firstCell = app.cells.firstMatch
        XCTAssertTrue(firstCell.waitForExistence(timeout: 2))
    }
    
    func test_tapListItem_navigatesToDetailView() {
        let app = XCUIApplication()
        app.launch()

        let firstCell = app.cells.firstMatch
        XCTAssertTrue(firstCell.waitForExistence(timeout: 3), "Expected at least one list item")

        // Tap the first item
        firstCell.tap()

        // Expect a label from the detail screen to appear
        let symbolLabel = app.staticTexts["CryptoSymbolLabel"]
        XCTAssertTrue(symbolLabel.waitForExistence(timeout: 3))
    }
    
    func test_detailView_displaysCryptoName() {
        let app = XCUIApplication()
        app.launch()

        let firstCell = app.cells.firstMatch
        XCTAssertTrue(firstCell.waitForExistence(timeout: 3))
        firstCell.tap()

        // Look for the name label (e.g. "Bitcoin", adjust if needed)
        let nameLabel = app.staticTexts.containing(NSPredicate(format: "label CONTAINS[c] %@", "Bitcoin")).firstMatch
        XCTAssertTrue(nameLabel.waitForExistence(timeout: 3), "Expected the crypto name to be visible in detail view")
    }


}
