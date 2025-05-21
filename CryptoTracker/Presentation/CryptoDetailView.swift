//
//  CryptoDetailViewController.swift
//  CryptoTracker
//
//  Created by selvaganapathy chinnakalai on 10/05/2025.
//

import SwiftUI

struct CryptoDetailView: View {
    @ObservedObject var viewModel: CryptoDetailViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(viewModel.crypto.name)
                .font(.largeTitle)
            Text("Symbol: \(viewModel.crypto.symbol)")
            Text("Price: $\(viewModel.crypto.price, specifier: "%.2f")")
            if let marketCap = viewModel.crypto.marketCap {
                Text("Market Cap: $\(marketCap, specifier: "%.2f")")
            }
            if let desc = viewModel.crypto.description {
                Text(desc)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding()
        .navigationTitle(viewModel.crypto.name)
    }
}
