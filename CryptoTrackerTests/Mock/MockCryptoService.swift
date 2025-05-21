
import XCTest
@testable import CryptoTracker

class MockCryptoService: CryptoService {
    var result: Result<[Crypto], Error> = .success([])

    func fetchCryptoList(page: Int, limit: Int) async throws -> [Crypto] {
        switch result {
        case .success(let cryptos): return cryptos
        case .failure(let error): throw error
        }
    }
}
