
import XCTest
@testable import CryptoTracker

class MockFetchUseCase: FetchCryptoListUseCase {
    var result: Result<[Crypto], Error> = .success([])

    func execute(page: Int, limit: Int) async throws -> [Crypto] {
        switch result {
        case .success(let cryptos): return cryptos
        case .failure(let error): throw error
        }
    }
}
