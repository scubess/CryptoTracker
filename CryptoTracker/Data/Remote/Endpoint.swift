//
//  Endpoint.swift
//  CryptoTracker
//
//  Created by selvaganapathy chinnakalai on 10/05/2025.
//

import Foundation

struct Endpoint {
    let fullPath: String
    var url: URL {
        return URL(string: "https://api.coingecko.com/api/v3\(fullPath)")!
    }
}
