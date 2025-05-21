//
//  CryptoListViewController.swift
//  CryptoTracker
//
//  Created by selvaganapathy chinnakalai on 10/05/2025.
//

import UIKit

class CryptoListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    var viewModel: CryptoListViewModel!
    private var filteredCryptos: [Crypto] = []
    private var isSearching = false

    init(viewModel: CryptoListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func refreshData() {
        viewModel.fetchInitialCryptos()
        tableView.refreshControl?.endRefreshing()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if viewModel == nil {
            // fallback for UI test mode
            let client = URLSessionNetworkClient()
            let service = CryptoService(client: client)
            let repo = CryptoRepository(service: service)
            let useCase = FetchCryptoListUseCase(repository: repo)
            viewModel = CryptoListViewModel(useCase: useCase)
            
        }
        tableView.register(CryptoCell.self, forCellReuseIdentifier: CryptoCell.identifier)
        tableView.rowHeight = 60
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        // ✅ Pull-to-refresh setup
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl

        viewModel.delegate = self
        viewModel.fetchInitialCryptos()
    }
}

// MARK: - ViewModel Delegate

extension CryptoListViewController: CryptoListViewModelDelegate {
    func didUpdateCryptos() {
        DispatchQueue.main.async {
            self.filteredCryptos = self.viewModel.cryptos
            self.tableView.reloadData()
        }
    }

    func didFailWithError(_ error: Error) {
        print("Error: \(error.localizedDescription)")
    }
}

// MARK: - UITableView

extension CryptoListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredCryptos.count : viewModel.cryptos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let crypto = isSearching ? filteredCryptos[indexPath.row] : viewModel.cryptos[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: CryptoCell.identifier, for: indexPath) as! CryptoCell
        cell.configure(with: crypto)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCrypto = isSearching ? filteredCryptos[indexPath.row] : viewModel.cryptos[indexPath.row]

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "CryptoDetailViewController") as! CryptoDetailViewController
        detailVC.crypto = selectedCrypto
        navigationController?.pushViewController(detailVC, animated: true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height

        if offsetY > contentHeight - frameHeight * 1.5 {
            viewModel.fetchMore()
        }
    }

}

// MARK: - UISearchBar

extension CryptoListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearching = !searchText.isEmpty
        filteredCryptos = viewModel.cryptos.filter {
            $0.name.lowercased().contains(searchText.lowercased()) ||
            $0.symbol.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        tableView.reloadData()
    }
}
