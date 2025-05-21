//
//  Crypto.swift
//  CryptoTracker
//
//  Created by selvaganapathy chinnakalai on 10/05/2025.
//

import Foundation

struct Crypto: Identifiable, Decodable, Equatable {
    let id: String
    let name: String
    let symbol: String
    let price: Double
    let description: String?
    let marketCap: Double?

    enum CodingKeys: String, CodingKey {
        case id, name, symbol, price, description
        case marketCap = "market_cap"
    }
}
