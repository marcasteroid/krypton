//
//  CoinDetailDataService.swift
//  Krypton
//
//  Created by Marco Margarucci on 16/09/23.
//

import Foundation
import Combine

final class CoinDetailDataService {
    @Published var coinDetails: CoinDetail? = nil
    var coinDetailSubscription: AnyCancellable?
    let coin: Coin
    
    init(coin: Coin) {
        self.coin = coin
        getCoinDetails()
    }
    
    public func getCoinDetails() {
        guard let url = URL(string: GlobalConstants.coinDetailURLHead + "\(coin.id)" + GlobalConstants.coinDetailURLTail) else { return }
        
        coinDetailSubscription = NetworkManager.download(url: url)
            .decode(type: CoinDetail.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] returnedCoinDetails in
                self?.coinDetails = returnedCoinDetails
                self?.coinDetailSubscription?.cancel()
            })
    }
}
