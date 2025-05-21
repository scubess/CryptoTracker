//
//  File.swift
//  CryptoTracker
//
//  Created by selvaganapathy chinnakalai on 21/05/2025.
//

import Foundation

final class CryptoRepositoryImpl: CryptoRepository {
    private let service: CryptoService
    
    init(service: CryptoService) {
        self.service = service
    }
    
    func fetchCryptos(page: Int, limit: Int) async throws -> [Crypto] {
        try await service.fetchCryptoList(page: page, limit: limit)
    }
}

