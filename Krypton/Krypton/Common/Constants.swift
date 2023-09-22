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
    // Coin detail URL head
    static let coinDetailURLHead: String = "https://api.coingecko.com/api/v3/coins/"
    // Coin detail URL tail
    static let coinDetailURLTail: String = "?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false"
    // Logo image name
    static let logoImageName: String = "logo";
}

// MARK: - Launch view
struct LaunchViewConstants {
    static let loadingText: String = "Loading your portfolio"
}

// MARK: - Home view
struct HomeViewConstants {
    static let livePricesHeaderTitle: String = "Live prices"
    static let portfolioHeaderTitle: String = "Portfolio"
    static let listCoinHeader: String = "Coin"
    static let listHoldingsHeader: String = "Holdings"
    static let listPriceHeader: String = "Price"
    static let refreshButtonImageName: String = "goforward"
    static let sortingIndicatorImageName: String = "chevron.down"
}

// MARK: - Circle button
struct CircleButtonConstants {
    static let plusButtonImageName: String = "plus"
    static let rightArrowImageName: String = "arrow.right"
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
    static let statisticBTCDominanceHeaderTitle: String = "Dominance"
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

// MARK: - Portfolio data service
struct PortfolioDataServiceConstants {
    static let containerName: String = "PortfolioContainer"
    static let entityName: String = "Portfolio"
    static let loadPersistentStoresErrorDescription: String = "[🔥] Error loading Core Data"
    static let fetchingPortfolioEntitiesErrorDescription: String = "[🔥] Error fetching portfolio entities"
    static let savingToCoreDataErrorDescription: String = "[🔥] Error saving to Core Data"
}

// MARK: - Detail view
struct DetailViewConstants {
    static let overviewSectionTitle: String = "Overview"
    static let additionalDetailsSectionTitle: String = "Additional details"
    static let readMoreButtonTitleNotExpanded: String = "Read more"
    static let readMoreButtonTitleExpanded: String = "Less"
    static let readMoreButtonImageNotExpanded: String = "chevron.down"
    static let readMoreButtonImageExpanded: String = "chevron.up"
    static let websiteLinkTitle: String = "Website"
    static let redditLinkTitle: String = "Reddit"
}

// MARK: - Detail view model
struct DetailViewModelConstants {
    static let statisticCurrentPrinceTitle: String = "Current price"
    static let statisticMarketCapitalizationTitle: String = "Market capitalization"
    static let statisticRankTitle: String = "Rank"
    static let statisticVolumeTitle: String = "Volume"
    static let statistic24hHighTitle: String = "24h high"
    static let statistic24hLowTitle: String = "24h low"
    static let statistic24hPriceChangeTitle: String = "24h price change"
    static let statistic24hMarketCapitalizationChangeTitle: String = "24h market capitalization change"
    static let statisticBlockTimeTitle: String = "Block time"
    static let statisticHashingAlgorithmTitle: String = "Hashing algorithm"
    static let statisticNotAvailable: String = "n/a"
}

