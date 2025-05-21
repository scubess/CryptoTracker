//
//  CryptoListViewModelTests.swift
//  CryptoTrackerTests
//
//  Created by selvaganapathy chinnakalai on 10/05/2025.
//

import XCTest
import PromiseKit
@testable import CryptoTracker

class CryptoListViewModelTests: XCTestCase {
    func test_fetchInitialCryptos_success() {
        let crypto = Crypto(id: "doge", symbol: "doge", name: "Dogecoin", image: "", current_price: 0.12, market_cap: 10000000, price_change_percentage_24h: 0.8)
        let useCase = MockFetchUseCase()
        useCase.result = .value([crypto])

        let viewModel = CryptoListViewModel(useCase: useCase)
        let spy = ViewModelDelegate()
        viewModel.delegate = spy

        let expectation = self.expectation(description: "ViewModel Success")
        spy.didUpdate = false

        viewModel.fetchInitialCryptos()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            XCTAssertTrue(spy.didUpdate)
            XCTAssertEqual(viewModel.cryptos.first?.name, "Dogecoin")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }
}
