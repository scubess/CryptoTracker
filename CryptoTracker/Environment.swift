//
//  Environment.swift
//  CryptoTracker
//
//  Created by selvaganapathy chinnakalai on 11/05/2025.
//

import Foundation

enum Environment {
    static var baseURL: String {
        Bundle.main.infoDictionary?["BASE_URL"] as? String ?? ""
    }

    static var isLoggingEnabled: Bool {
        (Bundle.main.infoDictionary?["LOGGING_ENABLED"] as? String) == "YES"
    }
}
