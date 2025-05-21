//
//  Crypto.swift
//  CryptoTracker
//
//  Created by selvaganapathy chinnakalai on 10/05/2025.
//

import Foundation

public struct Crypto: Codable {
    public let id: String
    public let symbol: String
    public let name: String
    public let image: String
    public let current_price: Double
    public let market_cap: Double?
    public let price_change_percentage_24h: Double?
}
