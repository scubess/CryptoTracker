//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by selvaganapathy chinnakalai on 21/05/2025.
//
import SwiftUI

@main
struct CryptoTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            let client = URLSessionNetworkClient()
            let service = APIService(client: client)
            let repository = CryptoRepositoryImpl(service: service)
            let useCase = FetchCryptoListUseCaseImpl(repository: repository)
            let viewModel = CryptoListViewModel(fetchCryptoUseCase: useCase)
            CryptoListView(viewModel: viewModel)
        }
    }
}

