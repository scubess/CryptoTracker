//
//  MockNetworkClient.swift
//  CryptoTrackerTests
//
//  Created by selvaganapathy chinnakalai on 10/05/2025.
//

import XCTest
import PromiseKit
@testable import CryptoTracker

class MockNetworkClient: NetworkClient {
    var result: Any?

    func get<T>(_ endpoint: Endpoint) -> Promise<T> where T : Decodable {
        if let casted = result as? T {
            return .value(casted)
        } else {
            return .init(error: NSError(domain: "", code: 0, userInfo: nil))
        }
    }
}
