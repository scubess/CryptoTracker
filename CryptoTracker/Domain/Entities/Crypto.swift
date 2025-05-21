//
//  Crypto.swift
//  CryptoTracker
//
//  Created by selvaganapathy chinnakalai on 10/05/2025.
//

import Foundation

struct Crypto: Identifiable, Decodable {
    let id: String
    let name: String
    let symbol: String
    let image: String
    let currentPrice: Double
    let marketCap: Double?
    let marketCapRank: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, symbol, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
    }
}
