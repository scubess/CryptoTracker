//
//  FetchCryptoListUseCase.swift
//  CryptoTrackerTests
//
//  Created by selvaganapathy chinnakalai on 10/05/2025.
//

import XCTest
@testable import CryptoTracker
import PromiseKit

class FetchCryptoListUseCaseTests: XCTestCase {
    func test_execute_success() {
        let coin = Crypto(id: "sol", symbol: "sol", name: "Solana", image: "", current_price: 170, market_cap: 500000000, price_change_percentage_24h: 1.0)
        let mockRepo = MockCryptoRepository()
        mockRepo.result = .value([coin])

        let useCase = FetchCryptoListUseCase(repository: mockRepo)

        let expectation = self.expectation(description: "UseCase Success")

        useCase.execute(page: 1).done { cryptos in
            XCTAssertEqual(cryptos.first?.id, "sol")
            expectation.fulfill()
        }.catch {_ in 
            XCTFail("Unexpected failure")
        }

        waitForExpectations(timeout: 1)
    }
}
