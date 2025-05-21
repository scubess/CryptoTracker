//
//  CryptoDetailViewModel.swift
//  CryptoTracker
//
//  Created by selvaganapathy chinnakalai on 21/05/2025.
//

import Foundation
import SwiftUI

@MainActor
final class CryptoDetailViewModel: ObservableObject {
    let crypto: Crypto

    init(crypto: Crypto) {
        self.crypto = crypto
    }
}
