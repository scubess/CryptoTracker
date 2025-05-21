//
//  CryptoListViewController.swift
//  CryptoTracker
//
//  Created by selvaganapathy chinnakalai on 10/05/2025.
//

import SwiftUI

struct CryptoListView: View {
    @StateObject var viewModel: CryptoListViewModel

    var body: some View {
        NavigationView {
            List(viewModel.cryptos) { crypto in
                VStack(alignment: .leading) {
                    Text(crypto.name)
                    Text("\(crypto.symbol) - $\(crypto.price, specifier: "%.2f")")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .overlay(Group {
                if viewModel.isLoading {
                    ProgressView()
                }
            })
            .navigationTitle("Cryptos")
        }
        .task {
            await viewModel.load()
        }
    }
}
