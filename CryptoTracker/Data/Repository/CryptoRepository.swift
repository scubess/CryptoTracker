//
//  CryptoRepository.swift
//  CryptoTracker
//
//  Created by selvaganapathy chinnakalai on 10/05/2025.
//

import Foundation

protocol CryptoRepository {
    func fetchCryptoList() async throws -> [Crypto]
}

final class CryptoRepositoryImpl: CryptoRepository {
    private let service: CryptoService

    init(service: CryptoService) {
        self.service = service
    }

    func fetchCryptoList() async throws -> [Crypto] {
        try await service.fetchCryptoList()
    }
}


