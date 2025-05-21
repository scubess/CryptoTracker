import XCTest
import iOSSnapshotTestCase
@testable import CryptoTracker

class CryptoDetailSnapshotTests: FBSnapshotTestCase {

    override func setUp() {
        super.setUp()
        self.recordMode = false // Set to true to generate image

        // ✅ Manually set the full reference image directory
        // This must match where you're storing the image inside your project
        self.folderName = "/ReferenceImages_64/CryptoTrackerTests.CryptoDetailSnapshotTests"
    }

    func testCryptoDetailView_looksCorrect() {
        let dummy = Crypto(
            id: "btc",
            symbol: "btc",
            name: "Bitcoin",
            image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png",
            current_price: 72000,
            market_cap: 1234567890,
            price_change_percentage_24h: 3.5
        )

        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: CryptoDetailViewController.self))
        let vc = storyboard.instantiateViewController(withIdentifier: "CryptoDetailViewController") as! CryptoDetailViewController
        vc.crypto = dummy
        vc.loadViewIfNeeded()

        let exp = expectation(description: "load image")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            exp.fulfill()
        }
        waitForExpectations(timeout: 2.0)

        // ✅ Snapshot this view
        FBSnapshotVerifyView(vc.view)
    }
}
