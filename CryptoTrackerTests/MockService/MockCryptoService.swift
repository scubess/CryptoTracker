//
//  CryptoRepository.swift
//  CryptoTrackerTests
//
//  Created by selvaganapathy chinnakalai on 10/05/2025.
//

import XCTest
@testable import CryptoTracker
import PromiseKit

class MockCryptoService: CryptoServiceProtocol {
    var result: Promise<[Crypto]>!

    func fetchCryptos(page: Int) -> Promise<[Crypto]> {
        return result
    }
}

