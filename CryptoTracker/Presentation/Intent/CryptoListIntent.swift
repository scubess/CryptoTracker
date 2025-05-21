//
//  CryptoListIntent.swift
//  CryptoTracker
//
//  Created by selvaganapathy chinnakalai on 21/05/2025.
//

import Foundation

/// Defines all user-triggered actions (intents) for the Crypto List screen
enum CryptoListIntent {
    case loadInitial
    case loadNextPage(currentItem: Crypto)
    case refresh
}

