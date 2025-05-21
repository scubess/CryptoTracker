//
//  FetchCryptoListUseCase.swift
//  CryptoTracker
//
//  Created by selvaganapathy chinnakalai on 10/05/2025.
//

import Foundation

protocol FetchCryptoListUseCase {
    func execute() async throws -> [Crypto]
}

final class FetchCryptoListUseCaseImpl: FetchCryptoListUseCase {
    private let repository: CryptoRepository

    init(repository: CryptoRepository) {
        self.repository = repository
    }

    func execute() async throws -> [Crypto] {
        try await repository.fetchCryptoList()
    }
}

