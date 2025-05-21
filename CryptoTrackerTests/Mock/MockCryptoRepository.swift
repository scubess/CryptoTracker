
import XCTest
@testable import CryptoTracker

class MockCryptoRepository: CryptoRepository {
    var result: Result<[Crypto], Error> = .success([])

    func fetchCryptos(page: Int, limit: Int) async throws -> [Crypto] {
        switch result {
        case .success(let cryptos): return cryptos
        case .failure(let error): throw error
        }
    }
}
