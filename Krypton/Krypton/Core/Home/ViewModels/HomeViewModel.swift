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
    @Published var statistics: [Statistic] = []
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    @Published var searchText: String = ""
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
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
        
        marketDataService.$markedData
            .map (mapGlobalMarketData)
            .sink { [weak self] (receivedStatistics) in
                self?.statistics = receivedStatistics
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
    
    private func mapGlobalMarketData(markedData: MarketData?) -> [Statistic] {
        var statistics: [Statistic] = []
        guard let data = markedData else { return statistics }
        let marketCap = Statistic(title: StatisticViewConstants.statisticMarketCapHeaderTitle, value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = Statistic(title: StatisticViewConstants.statisticVolumeHeaderTitle, value: data.volume)
        let btcDominance = Statistic(title: StatisticViewConstants.statisticBTCDominanceHeaderTitle, value: data.btcDominance)
        let portfolioValue = Statistic(title: StatisticViewConstants.statisticPortfolioValueHeaderTitle, value: "", percentageChange: 0)
        statistics.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolioValue
        ])
        return statistics
    }
}
