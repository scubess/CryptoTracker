
import XCTest
@testable import CryptoTracker

final class CryptoListViewModelTests: XCTestCase {

    func test_handle_loadInitial_success() async {
        let mockUseCase = MockFetchUseCase()
        let expected = Crypto(id: "doge", name: "Dogecoin", symbol: "doge", image: "", currentPrice: 0.12, marketCap: 10000000, marketCapRank: nil)
        mockUseCase.result = .success([expected])

        let viewModel = await CryptoListViewModel(fetchCryptoUseCase: mockUseCase)
        await viewModel.handle(.loadInitial)

        let cryptos = await viewModel.cryptos
        let isLoading = await viewModel.isLoading

        XCTAssertEqual(cryptos.count, 1)
        XCTAssertEqual(cryptos.first?.name, "Dogecoin")
        XCTAssertFalse(isLoading)
    }

    func test_handle_loadInitial_failure_setsError() async {
        let mockUseCase = MockFetchUseCase()
        mockUseCase.result = .failure(NSError(domain: "", code: 500, userInfo: [NSLocalizedDescriptionKey: "Server error"]))

        let viewModel = await CryptoListViewModel(fetchCryptoUseCase: mockUseCase)
        await viewModel.handle(.loadInitial)

        let cryptos = await viewModel.cryptos
        let error = await viewModel.errorMessage

        XCTAssertTrue(cryptos.isEmpty)
        XCTAssertEqual(error, "Server error")
    }

    func test_handle_loadNextPage_appendsResults() async {
        let crypto1 = Crypto(id: "btc", name: "Bitcoin", symbol: "btc", image: "", currentPrice: 20000, marketCap: 1000000, marketCapRank: 1)
        let crypto2 = Crypto(id: "eth", name: "Ethereum", symbol: "eth", image: "", currentPrice: 1000, marketCap: 500000, marketCapRank: 2)

        let mockUseCase = MockFetchUseCase()
        mockUseCase.result = .success([crypto1])
        let viewModel = await CryptoListViewModel(fetchCryptoUseCase: mockUseCase)
        await viewModel.handle(.loadInitial)

        mockUseCase.result = .success([crypto2])
        await viewModel.handle(.loadNextPage(currentItem: crypto1))

        let cryptos = await viewModel.cryptos

        XCTAssertEqual(cryptos.count, 2)
        XCTAssertEqual(cryptos.last?.name, "Ethereum")
    }
}
