//
//  CryptoCell.swift
//  CryptoTracker
//
//  Created by selvaganapathy chinnakalai on 10/05/2025.
//

import UIKit

class CryptoCell: UITableViewCell {
    static let identifier = "CryptoCell"

    let nameLabel = UILabel()
    let priceLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        priceLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        priceLabel.textColor = .systemGray

        let stack = UIStackView(arrangedSubviews: [nameLabel, priceLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }

    func configure(with crypto: Crypto) {
        nameLabel.text = "\(crypto.name) (\(crypto.symbol.uppercased()))"
        priceLabel.text = "$\(String(format: "%.2f", crypto.current_price))"
    }
}
