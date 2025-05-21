//
//  CryptoRepositoryTests.swift
//  CryptoTrackerTests
//
//  Created by selvaganapathy chinnakalai on 10/05/2025.
//

import XCTest
@testable import CryptoTracker
import PromiseKit

class CryptoRepositoryTests: XCTestCase {
    func test_getCryptocurrencies_success() {
        let expected = Crypto(id: "eth", symbol: "eth", name: "Ethereum", image: "", current_price: 3400, market_cap: 1234567890, price_change_percentage_24h: -2.1)
        let mockService = MockCryptoService()
        mockService.result = .value([expected])

        let repo = CryptoRepository(service: mockService)

        let expectation = self.expectation(description: "Repo Fetch")

        repo.getCryptocurrencies(page: 1).done { result in
            XCTAssertEqual(result.first?.symbol, "eth")
            expectation.fulfill()
        }.catch { _ in
            XCTFail("Should succeed")
        }

        waitForExpectations(timeout: 1)
    }
}
