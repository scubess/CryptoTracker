//
//  MockFetchUseCase.swift
//  CryptoTrackerTests
//
//  Created by selvaganapathy chinnakalai on 10/05/2025.
//

import XCTest
import PromiseKit
@testable import CryptoTracker

class MockFetchUseCase: FetchCryptoListUseCaseProtocol {
    var result: Promise<[Crypto]>!

    func execute(page: Int) -> Promise<[Crypto]> {
        return result
    }
}
