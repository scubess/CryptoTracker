//
//  CryptoService.swift
//  CryptoTracker
//
//  Created by selvaganapathy chinnakalai on 10/05/2025.
//

import Foundation

protocol CryptoService {
    func fetchCryptoList(page: Int, limit: Int) async throws -> [Crypto]
}

final class APIService: CryptoService {
    private let client: NetworkClient
    
    init(client: NetworkClient) {
        self.client = client
    }
    
    /// /// further improvement:
    /// - Validate input: Ensure `page` and `limit` are greater than zero.
    /// - Extract magic strings (e.g., "usd", "market_cap_desc") into constants or enums.
    /// - Add retry logic for transient errors (e.g. network drops).
    /// - Optionally add logging or monitoring for failures.
    func fetchCryptoList(page: Int, limit: Int) async throws -> [Crypto] {
        let endpoint = Endpoint(
            path: "/coins/markets",
            queryItems: [
                URLQueryItem(name: "vs_currency", value: "usd"),
                URLQueryItem(name: "order", value: "market_cap_desc"),
                URLQueryItem(name: "per_page", value: "\(limit)"),
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "sparkline", value: "false")
            ]
        )
        return try await client.get(endpoint)
    }
}
