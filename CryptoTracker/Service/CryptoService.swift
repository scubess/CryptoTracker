//
//  CryptoService.swift
//  CryptoTracker
//
//  Created by selvaganapathy chinnakalai on 10/05/2025.
//

import Foundation
import PromiseKit

protocol CryptoServiceProtocol {
    func fetchCryptos(page: Int) -> Promise<[Crypto]>
}

class CryptoService: CryptoServiceProtocol {
    private let client: NetworkClient

    init(client: NetworkClient) {
        self.client = client
    }

    func fetchCryptos(page: Int) -> Promise<[Crypto]> {
        let endpoint = Endpoint(fullPath: "/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=50&page=\(page)&sparkline=false")
        return client.get(endpoint)
    }
}
