//
//  DetailViewModel.swift
//  Krypton
//
//  Created by Marco Margarucci on 16/09/23.
//

import Foundation
import Combine

typealias Statistics = (overview: [Statistic], additional: [Statistic])

class DetailViewModel: ObservableObject {
    // MARK: - Properties
    @Published var overviewStatistics: [Statistic] = []
    @Published var additionalStatistics: [Statistic] = []
    @Published var coin: Coin
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: Coin) {
        self.coin = coin
        self.coinDetailService = CoinDetailDataService(coin: coin)
        addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink { [weak self] (returnedArrays) in
                self?.overviewStatistics = returnedArrays.overview
                self?.additionalStatistics = returnedArrays.additional
            }
            .store(in: &cancellables)
    }
    
    // Map data to statistics
    private func mapDataToStatistics(coinDetail: CoinDetail?, coin: Coin) -> Statistics {
        return (makeOverviewArray(coin: coin), makeAdditionalArray(coinDetail: coinDetail, coin: coin))
    }
    
    private func makeOverviewArray(coin: Coin) -> [Statistic] {
        let price = coin.currentPrice.asCurrencyWith6Decimals()
        let priceChangePercentage = coin.priceChangePercentage24H
        let priceStatistic = Statistic(title: DetailViewModelConstants.statisticCurrentPrinceTitle, value: price, percentageChange: priceChangePercentage)
        let marketCapitalization = "€" + (coin.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapitalizationChange = coin.marketCapChangePercentage24H
        let marketCapitalizationStatistic = Statistic(title: DetailViewModelConstants.statisticCurrentPrinceTitle, value: marketCapitalization, percentageChange: marketCapitalizationChange)
        let rank = "\(coin.rank)"
        let rankStatistic = Statistic(title: DetailViewModelConstants.statisticRankTitle, value: rank)
        let volume = "€" + (coin.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStatistic = Statistic(title: DetailViewModelConstants.statisticVolumeTitle, value: volume)
        let overviewArray: [Statistic] = [priceStatistic, marketCapitalizationStatistic, rankStatistic, volumeStatistic]
        return overviewArray
    }
    
    private func makeAdditionalArray(coinDetail: CoinDetail?, coin: Coin) -> [Statistic] {
        let high = coin.high24H?.asCurrencyWith6Decimals() ?? DetailViewModelConstants.statisticNotAvailable
        let highStatistic = Statistic(title: DetailViewModelConstants.statistic24hHighTitle, value: high)
        let low = coin.low24H?.asCurrencyWith6Decimals() ?? DetailViewModelConstants.statisticNotAvailable
        let lowStatistic = Statistic(title: DetailViewModelConstants.statistic24hLowTitle, value: low)
        let priceChange = coin.priceChange24H?.asCurrencyWith6Decimals() ?? DetailViewModelConstants.statisticNotAvailable
        let priceChangePercentage = coin.priceChangePercentage24H
        let priceChangeStatistic = Statistic(title: DetailViewModelConstants.statistic24hPriceChangeTitle, value: priceChange, percentageChange: priceChangePercentage)
        let marketCapChange = "€" + (coin.marketCapChangePercentage24H?.formattedWithAbbreviations() ?? "")
        let markeCapitalizationChange = coin.marketCapChangePercentage24H
        let marketCapizalizationChangeStatistic = Statistic(title: DetailViewModelConstants.statistic24hMarketCapitalizationChangeTitle, value: marketCapChange, percentageChange: markeCapitalizationChange)
        let blockTime = coinDetail?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? DetailViewModelConstants.statisticNotAvailable : "\(blockTime)"
        let blockStatistic = Statistic(title: DetailViewModelConstants.statisticBlockTimeTitle, value: blockTimeString)
        let hashing = coinDetail?.hashingAlgorithm ?? DetailViewModelConstants.statisticNotAvailable
        let hashingStatistic = Statistic(title: DetailViewModelConstants.statisticHashingAlgorithmTitle, value: hashing)
        let additionalArray: [Statistic] = [highStatistic, lowStatistic, priceChangeStatistic, marketCapizalizationChangeStatistic, blockStatistic, hashingStatistic]
        return additionalArray
    }
}
