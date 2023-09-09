//
//  CoinDataService.swift
//  Krypton
//
//  Created by Marco Margarucci on 09/09/23.
//

import Foundation
import Combine

final class CoinDataService {
    @Published var allCoins: [Coin] = []
    var coinSubscription: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    private func getCoins() {
        guard let url = URL(string: GlobalConstants.baseURL) else { return }
        
        coinSubscription = NetworkManager.download(url: url)
            .decode(type: [Coin].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] receivedCoins in
                self?.allCoins = receivedCoins
                self?.coinSubscription?.cancel()
            })
    }
}
