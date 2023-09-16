//
//  DetailViewModel.swift
//  Krypton
//
//  Created by Marco Margarucci on 16/09/23.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    // MARK: - Properties
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: Coin) {
        self.coinDetailService = CoinDetailDataService(coin: coin)
        addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailService.$coinDetails
            .sink { (returnedCoinDetails) in
                debugPrint("[DEBUG]: RECEIVED COIN DETAIL DATA")
                debugPrint(returnedCoinDetails)
            }
            .store(in: &cancellables)
    }
}
