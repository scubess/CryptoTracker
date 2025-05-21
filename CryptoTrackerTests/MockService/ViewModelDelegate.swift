//
//  ViewModelDelegate.swift
//  CryptoTrackerTests
//
//  Created by selvaganapathy chinnakalai on 10/05/2025.
//

import XCTest
import PromiseKit
@testable import CryptoTracker

class ViewModelDelegate: CryptoListViewModelDelegate {
    var didUpdate = false
    var didFail = false

    func didUpdateCryptos() {
        didUpdate = true
    }

    func didFailWithError(_ error: Error) {
        didFail = true
    }
}

