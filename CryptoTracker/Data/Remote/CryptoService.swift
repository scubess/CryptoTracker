//
//  CryptoService.swift
//  CryptoTracker
//
//  Created by selvaganapathy chinnakalai on 10/05/2025.
//

import Foundation

protocol CryptoService {
    func fetchCryptoList() async throws -> [Crypto]
}

final class APIService: CryptoService {
    private let client: NetworkClient
    
    init(client: NetworkClient) {
        self.client = client
    }
    
    func fetchCryptoList() async throws -> [Crypto] {
        let endpoint = Endpoint(fullPath: "/cryptos")
        return try await client.get(endpoint)
    }
}
