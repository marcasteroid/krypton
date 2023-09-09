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
