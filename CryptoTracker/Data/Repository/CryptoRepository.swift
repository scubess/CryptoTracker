//
//  CryptoRepository.swift
//  CryptoTracker
//
//  Created by selvaganapathy chinnakalai on 10/05/2025.
//

import Foundation

protocol CryptoRepository {
    func fetchCryptos(page: Int, limit: Int) async throws -> [Crypto]
}
