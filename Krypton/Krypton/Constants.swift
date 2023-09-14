//
//  Constants.swift
//  Krypton
//
//  Created by Marco Margarucci on 08/09/23.
//

import Foundation

// MARK: - Global
struct GlobalConstants {
    // Base URL
    static let baseURL: String = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h&locale=it"
    // Market URL
    static let marketURL: String = "https://api.coingecko.com/api/v3/global"
}

// MARK: - Home view
struct HomeViewConstants {
    // Live prices header title
    static let livePricesHeaderTitle: String = "Live prices"
    // Portfolio header title
    static let portfolioHeaderTitle: String = "Portfolio"
    // List coin header
    static let listCoinHeader: String = "Coin"
    // List holdings header
    static let listHoldingsHeader: String = "Holdings"
    // List price header
    static let listPriceHeader: String = "Price"
}

// MARK: - Circle button
struct CircleButtonConstants {
    // Info button image name
    static let infoButtonImageName: String = "info"
    // Plus button image name
    static let plusButtonImageName: String = "plus"
    // Right arrow button image name
    static let rightArrowImageName: String = "arrow.right"
    // Close
    static let closeImageName: String = "xmark.circle.fill"
}

// MARK: - Network manager
struct NetworkManagerConstants {
    static let networkErrorBadURLResponseErrorDescription: String = "[🔥] Bad response from URL"
    static let networkErrorUnknownErrorDescription: String = "[💀] Unknown error"
}

// MARK: - Coin image view
struct CoinImageViewConstants {
    static let imagePlaceholder: String = "questionmark"
}

// MARK: - Coin image service
struct CoinImageServiceConstants {
    static let imageFolderName: String = "coin_images"
}

// MARK: - Search bar
struct SearchBarConstants {
    static let searchBarLeadingImageName: String = "magnifyingglass"
    static let searchBarClearTextImageName: String = "xmark.circle.fill"
    static let searchBarPlaceholder: String = "Search by name or symbol"
}

// MARK: - Statistic view
struct StatisticViewConstants {
    static let arrow: String = "arrow.up"
    static let statisticMarketCapHeaderTitle: String = "Market cap"
    static let statisticVolumeHeaderTitle: String = "Volume 24h"
    static let statisticBTCDominanceHeaderTitle: String = "BTC dominance"
    static let statisticPortfolioValueHeaderTitle: String = "Portfolio value"
}

// MARK: - Portfolio view
struct PortfolioViewConstants {
    static let pageTitle: String = "Edit portfolio"
    static let currentPriceOfCoin: String = "Current price of"
    static let amountInPortfolio: String = "Amount in your portfolio"
    static let textFieldAmountPlaceholder: String = "Ex: 4.6"
    static let currentValue: String = "Current value"
    static let saveButtonTitle: String = "SAVE"
    static let savedButtonTitle: String = "SAVED"
    static let selectedCoinImageName: String = "circle.fill"
}
