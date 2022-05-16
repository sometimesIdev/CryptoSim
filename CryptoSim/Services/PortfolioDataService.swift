//
//  PortfolioDataService.swift
//  CryptoSim
//
//  Created by Pat Butler on 2022-05-09.
//

import Foundation
import CoreData
import UIKit

class PortfolioDataService {
  private let container: NSPersistentContainer
  private let containerName: String = "PortfolioContainer"
  private let enitityName: String = "PortfolioEntity"
  
  @Published var savedEntities: [PortfolioEntity] = []
  
  init() {
    container = NSPersistentContainer(name: containerName)
    container.loadPersistentStores { _, error in
      if let error = error {
        print("Error loading Core Data! \(error)")
      }
      self.getPortfolio()
    }
  }
  
  // MARK: - PUBLIC ACCESS FUNC
  
  func updatePortfolio(coin: Coin, amount: Double) {
    // check if coin is already in portfolio
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
  
  
  // MARK: - PRIVATE
  
  private func getPortfolio() {
    let request = NSFetchRequest<PortfolioEntity>(entityName: enitityName)
    do {
      savedEntities = try container.viewContext.fetch(request)
    } catch let error {
      print("Error fetching Portfolio Entities. \(error)")
    }
  }
  
  private func add(coin: Coin, amount: Double) {
    let entity = PortfolioEntity(context: container.viewContext)
    entity.coinID = coin.id
    entity.amount = amount
    applyChanges()
  }
  
  private func update(entity: PortfolioEntity, amount: Double) {
    entity.amount = amount
    applyChanges()
  }
  
  private func delete(entity: PortfolioEntity) {
    container.viewContext.delete(entity)
    applyChanges()
  }
  
  private func save() {
    do {
      try container.viewContext.save()
    } catch let error  {
      print("Error saving to Core Data. \(error)")
    }
  }
  
  private func applyChanges() {
    save()
    getPortfolio()
  }
}
