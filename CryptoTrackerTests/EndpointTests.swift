//
//  EndpointTests.swift
//  CryptoTrackerTests
//
//  Created by selvaganapathy chinnakalai on 21/05/2025.
//

import XCTest
@testable import CryptoTracker

final class EndpointTests: XCTestCase {

    func test_endpoint_buildsFullURLCorrectly() {
        let endpoint = Endpoint(path: "/coins/markets", queryItems: [
            URLQueryItem(name: "vs_currency", value: "usd"),
            URLQueryItem(name: "page", value: "1")
        ])

        let url = endpoint.url.absoluteString
        XCTAssertTrue(url.contains("coins/markets"))
        XCTAssertTrue(url.contains("vs_currency=usd"))
        XCTAssertTrue(url.contains("page=1"))
    }

}
