//
//  FavoriteCoinServiceProtocol.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 28/02/2025.
//


import CoreData

protocol FavoriteCoinServiceProtocol: AnyObject {
    func saveFavoriteCoin(_ coin: Coin, completion: @escaping (Bool) -> Void)
    func fetchFavorites() async throws -> NSFetchedResultsController<CoinEntity>
    func removeFavoriteCoin(entity: CoinEntity, completion: @escaping (Bool) -> Void)
}
