//
//  APIClientTests.swift .swift
//  CryptoTrackerTests
//
//  Created by selvaganapathy chinnakalai on 21/05/2025.
//

import XCTest
@testable import CryptoTracker


final class APIClientTests: XCTestCase {

    func test_get_success_returnsDecodedData() async throws {
        struct MockResponse: Decodable, Equatable { let name: String }

        let expected = MockResponse(name: "Bitcoin")
        let mockClient = MockNetworkClient()
        mockClient.result = .success(expected)

        let client: NetworkClient = mockClient
        let result: MockResponse = try await client.get(Endpoint(path: "/mock"))

        XCTAssertEqual(result.name, "Bitcoin")
    }

}
