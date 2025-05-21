//
//  Endpoint.swift
//  CryptoTracker
//
//  Created by selvaganapathy chinnakalai on 10/05/2025.
//

import Foundation

struct Endpoint {
    let path: String
    var queryItems: [URLQueryItem] = []

    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.coingecko.com"
        components.path = "/api/v3\(path)"
        components.queryItems = queryItems
        return components.url!
    }
}
