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

    init(fetchCryptoUseCase: FetchCryptoListUseCase) {
        self.fetchCryptoUseCase = fetchCryptoUseCase
    }

    func load() async {
        isLoading = true
        defer { isLoading = false }

        do {
            cryptos = try await fetchCryptoUseCase.execute()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
