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
        VStack(alignment: .leading, spacing: 16) {
            Text(crypto.name)
                .font(.largeTitle)
            Text("Symbol: \(crypto.symbol)")
            Text("Price: $\(crypto.currentPrice, specifier: "%.2f")")
        }
        .padding()
        .navigationTitle(crypto.name)
    }
}
