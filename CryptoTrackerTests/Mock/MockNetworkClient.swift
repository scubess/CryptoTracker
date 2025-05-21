//
//  MockNetworkClient.swift
//  CryptoTrackerTests
//
//  Created by selvaganapathy chinnakalai on 21/05/2025.
//

import Foundation
@testable import CryptoTracker

class MockNetworkClient: NetworkClient {
    var result: Result<Any, Error> = .success([])

    func get<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        switch result {
        case .success(let value):
            guard let typed = value as? T else {
                throw NSError(domain: "MockNetworkClient", code: 1, userInfo: [
                    NSLocalizedDescriptionKey: "Type mismatch: cannot cast mock value to expected type"
                ])
            }
            return typed
        case .failure(let error):
            throw error
        }
    }
}
