//
//  FetchCryptoListUseCase.swift
//  CryptoTracker
//
//  Created by selvaganapathy chinnakalai on 10/05/2025.
//

import Foundation
import PromiseKit

protocol FetchCryptoListUseCaseProtocol {
    func execute(page: Int) -> Promise<[Crypto]>
}

class FetchCryptoListUseCase: FetchCryptoListUseCaseProtocol {
    private let repository: CryptoRepositoryProtocol

    init(repository: CryptoRepositoryProtocol) {
        self.repository = repository
    }

    func execute(page: Int) -> Promise<[Crypto]> {
        return repository.getCryptocurrencies(page: page)
    }
}

