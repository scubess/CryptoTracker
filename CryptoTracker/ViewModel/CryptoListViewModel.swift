//
//  CryptoListViewModel.swift
//  CryptoTracker
//
//  Created by selvaganapathy chinnakalai on 10/05/2025.
//

import Foundation
import PromiseKit

protocol CryptoListViewModelDelegate: AnyObject {
    func didUpdateCryptos()
    func didFailWithError(_ error: Error)
}

class CryptoListViewModel {
    private let useCase: FetchCryptoListUseCaseProtocol
    private(set) var cryptos: [Crypto] = []
    private var currentPage = 1
    private var isLoading = false
    weak var delegate: CryptoListViewModelDelegate?

    init(useCase: FetchCryptoListUseCaseProtocol) {
        self.useCase = useCase
    }

    func fetchInitialCryptos() {
        currentPage = 1
        cryptos.removeAll()
        fetchMore()
    }

    func fetchMore() {
        guard !isLoading else { return }
        isLoading = true

        useCase.execute(page: currentPage).done { [weak self] newCryptos in
            guard let self = self else { return }
            self.cryptos += newCryptos
            self.currentPage += 1
            self.delegate?.didUpdateCryptos()
        }.catch { [weak self] error in
            self?.delegate?.didFailWithError(error)
        }.finally {
            self.isLoading = false
        }
    }

    func numberOfItems() -> Int { cryptos.count }

    func crypto(at index: Int) -> Crypto { cryptos[index] }
}
