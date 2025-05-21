//
//  File.swift
//  CryptoTracker
//
//  Created by selvaganapathy chinnakalai on 21/05/2025.
//

import Foundation


final class FetchCryptoListUseCaseImpl: FetchCryptoListUseCase {
    private let repository: CryptoRepository

    init(repository: CryptoRepository) {
        self.repository = repository
    }

    func execute(page: Int, limit: Int) async throws -> [Crypto] {
            try await repository.fetchCryptos(page: page, limit: limit)
    }
}
