//
//  FavoriteCoinService.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 28/02/2025.
//

import Foundation
import CoreData

class FavoriteCoinService : FavoriteCoinServiceProtocol {
    var coreDataStack: CoreDataStackProtocol
    
    init(coreDataStack: CoreDataStack = CoreDataStack.shared) {
        self.coreDataStack = coreDataStack
    }
    func saveFavoriteCoin(_ coin: Coin, completion: @escaping (Bool) -> Void) {
        let entity = CoinEntity(context: coreDataStack.managedContext)
        entity.uuid = coin.uuid
        entity.name = coin.name
        entity.symbol = coin.symbol
        entity.price = coin.price
        entity.btcPrice = coin.btcPrice
        entity.marketCap = coin.marketCap
        entity.change = coin.change
        entity.rank = String(coin.rank)
        entity.iconUrl = coin.iconUrl
        if let sparkline = coin.sparkline?.compactMap({ $0 }) {
            entity.sparkline = try? JSONEncoder().encode(sparkline)
        }
        coreDataStack.saveContextChanges { hasSaved in
            completion(hasSaved)
        }
    }
    func fetchFavorites() async throws -> NSFetchedResultsController<CoinEntity> {
        let fetchRequest: NSFetchRequest<CoinEntity> = CoinEntity.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "rank", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let fetController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataStack.managedContext, sectionNameKeyPath: nil, cacheName: nil)
        
        try fetController.performFetch()
        return fetController
    }
    func removeFavoriteCoin(entity: CoinEntity, completion: @escaping (Bool) -> Void) {
        let context = coreDataStack.managedContext
        context.delete(entity)
        coreDataStack.saveContextChanges { hasDeleted in
            completion(hasDeleted)
        }
        
    }
    

}
