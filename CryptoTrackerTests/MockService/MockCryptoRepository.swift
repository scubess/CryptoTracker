//
//  MockCryptoRepository.swift
//  CryptoTrackerTests
//
//  Created by selvaganapathy chinnakalai on 10/05/2025.
//

import XCTest
@testable import CryptoTracker
import PromiseKit

class MockCryptoRepository: CryptoRepositoryProtocol {
    var result: Promise<[Crypto]>!

    func getCryptocurrencies(page: Int) -> Promise<[Crypto]> {
        return result
    }
}

