//
//  CryptoDetailViewController.swift
//  CryptoTracker
//
//  Created by selvaganapathy chinnakalai on 10/05/2025.
//

import UIKit

public class CryptoDetailViewController: UIViewController {

    @IBOutlet weak var coinImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var marketCapLabel: UILabel!

    var crypto: Crypto!

    public override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        guard let crypto = crypto else { return }

        nameLabel.text = "\(crypto.name) (\(crypto.symbol.uppercased()))"
        priceLabel.text = "Current Price: $\(String(format: "%.2f", crypto.current_price))"

        if let change = crypto.price_change_percentage_24h {
            let sign = change >= 0 ? "+" : ""
            changeLabel.text = "24h Change: \(sign)\(String(format: "%.2f", change))%"
            changeLabel.textColor = change >= 0 ? .systemGreen : .systemRed
        } else {
            changeLabel.text = "24h Change: --"
        }

        if let cap = crypto.market_cap {
            marketCapLabel.text = "Market Cap: $\(Int(cap).formattedWithSeparator())"
        } else {
            marketCapLabel.text = "Market Cap: --"
        }

        loadImage(from: crypto.image)
    }

    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                DispatchQueue.main.async {
                    self.coinImageView.image = UIImage(data: data)
                }
            }
        }.resume()
    }
}
