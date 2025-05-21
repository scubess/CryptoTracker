//
//  CryptoDetailViewController.swift
//  CryptoTracker
//
//  Created by selvaganapathy chinnakalai on 10/05/2025.
//

import SwiftUI

struct CryptoDetailView: View {
    let crypto: Crypto

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                AsyncImage(url: URL(string: crypto.image)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(height: 150)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }

                Text(crypto.name)
                    .font(.title)
                Text("Symbol: \(crypto.symbol.uppercased())")
                    .foregroundColor(.secondary)
                    .accessibilityIdentifier("CryptoSymbolLabel")
                Text("Price: $\(crypto.currentPrice, specifier: "%.2f")")
                    .font(.title2)
            }
            .padding()
        }
        .navigationTitle(crypto.name)
    }
}
