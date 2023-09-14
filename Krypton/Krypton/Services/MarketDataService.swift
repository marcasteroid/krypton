//
//  MarketDataService.swift
//  Krypton
//
//  Created by Marco Margarucci on 11/09/23.
//

import Foundation
import Combine

final class MarketDataService {
    @Published var marketData: MarketData? = nil
    var marketDataSubscription: AnyCancellable?
    
    init() {
        getMarkedData()
    }
    
    private func getMarkedData() {
        guard let url = URL(string: GlobalConstants.marketURL) else { return }
        
        marketDataSubscription = NetworkManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] receivedGlobalData in
                self?.marketData = receivedGlobalData.data
                self?.marketDataSubscription?.cancel()
            })
    }
}
