//
//  CryptoListViewController.swift
//  CryptoTracker
//
//  Created by selvaganapathy chinnakalai on 10/05/2025.
//

import SwiftUI

extension String: Identifiable {
    public var id: String { self }
}

struct CryptoListView: View {
    @StateObject var viewModel: CryptoListViewModel

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.cryptos.isEmpty && !viewModel.isLoading {
                    Text("No data available")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(viewModel.cryptos) { crypto in
                        NavigationLink(destination: CryptoDetailView(crypto: crypto)) {
                            VStack(alignment: .leading) {
                                Text(crypto.name)
                                    .font(.headline)
                                Text("\(crypto.symbol) - $\(crypto.currentPrice, specifier: "%.2f")")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                }
            }
            .navigationTitle("Cryptos")
            .alert(item: $viewModel.errorMessage) { message in
                Alert(title: Text("Error"), message: Text(message), dismissButton: .default(Text("OK")))
            }
        }
        .task {
            await viewModel.load()
        }

        .task {
            await viewModel.load()
        }
    }
}
