//
//  CryptoServiceTests.swift
//  CryptoTrackerTests
//
//  Created by selvaganapathy chinnakalai on 10/05/2025.
//

import XCTest
@testable import CryptoTracker

class CryptoServiceTests: XCTestCase {
    func test_fetchCryptos_success() {
        let crypto = Crypto(id: "btc", symbol: "btc", name: "Bitcoin", image: "", current_price: 10000, market_cap: 123456789, price_change_percentage_24h: 3.5)
        let mockClient = MockNetworkClient()
        mockClient.result = [crypto]

        let service = CryptoService(client: mockClient)

        let expectation = self.expectation(description: "Fetch Success")

        service.fetchCryptos(page: 1).done { result in
            XCTAssertEqual(result.count, 1)
            XCTAssertEqual(result.first?.name, "Bitcoin")
            expectation.fulfill()
        }.catch { _ in
            XCTFail("Should not fail")
        }

        waitForExpectations(timeout: 1)
    }
}
