//
//  CryptoListViewController.swift
//  CryptoTracker
//
//  Created by selvaganapathy chinnakalai on 10/05/2025.
//

import SwiftUI

extension String: Identifiable {
    public var id: String { self }
}

struct CryptoListView: View {
    @StateObject var viewModel: CryptoListViewModel

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.cryptos.isEmpty && !viewModel.isLoading {
                    Text("No data available")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(viewModel.cryptos) { crypto in
                        NavigationLink(destination: CryptoDetailView(crypto: crypto)) {
                            HStack {
                                AsyncImage(url: URL(string: crypto.image)) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                            .frame(width: 40, height: 40)
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 40, height: 40)
                                            .clipShape(RoundedRectangle(cornerRadius: 6))
                                    case .failure:
                                        Image(systemName: "photo")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 40, height: 40)
                                            .foregroundColor(.gray)
                                    @unknown default:
                                        EmptyView()
                                    }
                                }

                                VStack(alignment: .leading) {
                                    Text(crypto.name)
                                        .font(.headline)
                                    Text("\(crypto.symbol.uppercased()) - $\(crypto.currentPrice, specifier: "%.2f")")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                            .onAppear {
                                Task {
                                    await viewModel.handle(.loadNextPage(currentItem: crypto))
                                }
                            }
                        }
                    }
                }
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                }
            }
            .navigationTitle("Cryptos")
            .alert(item: $viewModel.errorMessage) { message in
                Alert(title: Text("Error"),
                      message: Text(message),
                      dismissButton: .default(Text("OK")))
            }
        }
        .task {
            await viewModel.handle(.loadInitial)
        }
    }
}
