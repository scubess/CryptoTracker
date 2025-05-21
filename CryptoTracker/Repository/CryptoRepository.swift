//
//  CryptoRepository.swift
//  CryptoTracker
//
//  Created by selvaganapathy chinnakalai on 10/05/2025.
//

import Foundation
import PromiseKit

protocol CryptoRepositoryProtocol {
    func getCryptocurrencies(page: Int) -> Promise<[Crypto]>
}

class CryptoRepository: CryptoRepositoryProtocol {
    private let service: CryptoServiceProtocol

    init(service: CryptoServiceProtocol) {
        self.service = service
    }

    func getCryptocurrencies(page: Int) -> Promise<[Crypto]> {
        return service.fetchCryptos(page: page)
    }
}
