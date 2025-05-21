//
//  APIClient.swift
//  CryptoTracker
//
//  Created by selvaganapathy chinnakalai on 10/05/2025.
//

import Foundation

protocol NetworkClient {
    func get<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

final class URLSessionNetworkClient: NetworkClient {
    func get<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = "GET"

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            let status = (response as? HTTPURLResponse)?.statusCode ?? 0
            print(status)
            let raw = String(data: data, encoding: .utf8) ?? "No data"
            throw NSError(domain: "", code: status, userInfo: [
                NSLocalizedDescriptionKey: "Server error: \(status), response: \(raw)"
                
            ])
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("❌ Decoding error: \(error)")
            if let jsonStr = String(data: data, encoding: .utf8) {
                print("📦 Raw JSON: \(jsonStr)")
            }
            throw error
        }
    }
}
