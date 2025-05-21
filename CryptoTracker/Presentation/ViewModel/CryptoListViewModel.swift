//
//  CryptoListViewModel.swift
//  CryptoTracker
//
//  Created by selvaganapathy chinnakalai on 10/05/2025.
//

import Combine

@MainActor
final class CryptoListViewModel: ObservableObject {
    @Published private(set) var cryptos: [Crypto] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private let fetchCryptoUseCase: FetchCryptoListUseCase
    private var currentPage = 1
    private let perPage = 50
    private var isLoadingPage = false
    private var allDataLoaded = false

    init(fetchCryptoUseCase: FetchCryptoListUseCase) {
        self.fetchCryptoUseCase = fetchCryptoUseCase
    }

    func handle(_ intent: CryptoListIntent) async {
        switch intent {
        case .loadInitial:
            await loadInitial()
        case .loadNextPage(let currentItem):
            await loadMoreIfNeeded(currentItem: currentItem)
        case .refresh:
            await refresh()
        }
    }

    private func loadInitial() async {
        isLoading = true
        currentPage = 1
        allDataLoaded = false
        do {
            let result = try await fetchCryptoUseCase.execute(page: currentPage, limit: perPage)
            cryptos = result
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    private func refresh() async {
        cryptos = []
        currentPage = 1
        allDataLoaded = false
        await handle(.loadInitial)
    }

    private func loadMoreIfNeeded(currentItem: Crypto) async {
        guard !isLoadingPage, !allDataLoaded else { return }
        let thresholdIndex = cryptos.index(cryptos.endIndex, offsetBy: -5)
        if let index = cryptos.firstIndex(where: { $0.id == currentItem.id }), index >= thresholdIndex {
            isLoadingPage = true
            currentPage += 1
            do {
                let more = try await fetchCryptoUseCase.execute(page: currentPage, limit: perPage)
                if more.isEmpty {
                    allDataLoaded = true
                } else {
                    cryptos.append(contentsOf: more)
                }
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoadingPage = false
        }
    }
}
