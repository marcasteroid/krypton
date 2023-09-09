//
//  HomeViewModel.swift
//  Krypton
//
//  Created by Marco Margarucci on 09/09/23.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    // MARK: - Properties
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    @Published var searchText: String = ""
    private let coinDataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        // Update all coins
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
    private func filterCoins(text: String, coins: [Coin]) -> [Coin] {
        guard !text.isEmpty else {
            return coins
        }
        let lowercasedText = text.lowercased()
        return coins.filter{ (coin) -> Bool in
            return coin.name.lowercased().contains(lowercasedText) || coin.symbol.contains(lowercasedText) || coin.id.contains(lowercasedText)
        }
    }
}
