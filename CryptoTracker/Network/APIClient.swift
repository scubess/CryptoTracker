//
//  APIClient.swift
//  CryptoTracker
//
//  Created by selvaganapathy chinnakalai on 10/05/2025.
//

import Foundation
import PromiseKit

protocol NetworkClient {
    func get<T: Decodable>(_ endpoint: Endpoint) -> Promise<T>
}

class URLSessionNetworkClient: NetworkClient {
    func get<T: Decodable>(_ endpoint: Endpoint) -> Promise<T> {
        return Promise { seal in
            var request = URLRequest(url: endpoint.url)
            request.httpMethod = "GET"

            URLSession.shared.dataTask(with: request) { data, response, error in
                
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    let status = (response as? HTTPURLResponse)?.statusCode ?? 0
                    let raw = String(data: data ?? Data(), encoding: .utf8) ?? "No data"
                    return seal.reject(NSError(domain: "", code: status, userInfo: [
                        NSLocalizedDescriptionKey: "Server error: \(status), response: \(raw)"
                    ]))
                }

                if let error = error {
                    return seal.reject(error)
                }
                guard let data = data else {
                    return seal.reject(NSError(domain: "", code: -1, userInfo: nil))
                }

                do {
                    let decoded = try JSONDecoder().decode(T.self, from: data)
                    seal.fulfill(decoded)
                } catch {
                    print("❌ Decoding error: \(error)")
                    if let jsonStr = String(data: data, encoding: .utf8) {
                        print("📦 Raw JSON: \(jsonStr)")
                    }
                    seal.reject(error)
                }

            }.resume()
        }
    }
}
