//
//  PortfolioDataService.swift
//  Krypton
//
//  Created by Marco Margarucci on 14/09/23.
//

import Foundation
import CoreData

class PortfolioDataService {
    // MARK: - Constants
    private let container: NSPersistentContainer
    private let containerName: String = PortfolioDataServiceConstants.containerName
    private let entityName: String = PortfolioDataServiceConstants.entityName
    @Published var savedEntities: [Portfolio] = []
    
    init() {
        self.container = NSPersistentContainer(name: self.containerName)
        self.container.loadPersistentStores { (_, error) in
            if let error = error {
                debugPrint(PortfolioDataServiceConstants.loadPersistentStoresErrorDescription + ": " + error.localizedDescription)
            }
            self.getPortfolio()
        }
    }
    
    // MARK: - Public functions
    func updatePortfolio(coin: Coin, amount: Double) {
        // Check if the coin is already in the portfolio
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    // MARK: - Private functions
    
    private func getPortfolio() {
        let request = NSFetchRequest<Portfolio>(entityName: self.entityName)
        do {
            self.savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            debugPrint(PortfolioDataServiceConstants.fetchingPortfolioEntitiesErrorDescription + ": " + error.localizedDescription)
        }
    }
    
    private func add(coin: Coin, amount: Double) {
        let entity = Portfolio(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    private func update(entity: Portfolio, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func delete(entity: Portfolio) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            debugPrint(PortfolioDataServiceConstants.savingToCoreDataErrorDescription + ": " + error.localizedDescription)
        }
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    }
}
