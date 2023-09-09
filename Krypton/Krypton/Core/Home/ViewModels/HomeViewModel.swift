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
        coinDataService.$allCoins
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
}
