//
//  CoinsViewModel.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 25/02/2025.
//

import CoreData

final class CoinsViewModel: AnyObject {
    private let coinWebService: CoinWebServiceProtocol
    private let favoriteCoinService: FavoriteCoinServiceProtocol
    
    init(coinWebService: CoinWebServiceProtocol = CoinWebService(),
         favoriteCoinService: FavoriteCoinServiceProtocol = FavoriteCoinService()) {
        self.coinWebService = coinWebService
        self.favoriteCoinService = favoriteCoinService
    }
    private var offset = 0
    private var limit = 20
    private var isLoading = false
    private var coinList: [Coin] = []
    var onDataUpdated: (() -> Void)?
    var onError: ((String?) -> Void)?
    var onFetchError: ((String?) -> Void)?
    
    var coinsCount: Int {
        coinList.count
    }
    func coin(at index: Int) -> Coin {
        return coinList[index]
    }
    var sortOption: CoinSortOption = .highestPrice {
        didSet {
            sortCoins()
        }
    }
    func fetchCoin(){
        guard !isLoading , offset < CacheKeys.MAX_COINS else { return }
        isLoading = true
        coinWebService.fetchCoins(offset: offset, limit: limit) { [weak self] coinResponse, errorMsg in
            guard let self = self else { return }
            self.isLoading = false
            if coinResponse?.status == StatusEnum.statusOk.rawValue {
                if let coins = coinResponse?.data?.coins, !coins.isEmpty {
                    self.coinList.append(contentsOf: coins)
                    self.offset += coins.count
                    self.sortCoins()
                    self.onDataUpdated?()
                    logInfo(self.coinList.count)
                }else {
                    // nb if data is empty we should load data ...
                    logError("Empty data")
                }
                
            } else{
                self.onError?(errorMsg)
                logError("OnViewModel:: \(String(describing: errorMsg))")
            }
        }
    }
    
    func saveFavoriteCoin(coin: Coin){
        favoriteCoinService.saveFavoriteCoin(coin) { isSuccessful in
            
        }
    }
    
    func fetchFavoriteCoin() async -> NSFetchedResultsController<CoinEntity>? {
        do {
            return try await favoriteCoinService.fetchFavorites()
        }catch {
            onFetchError?(error.localizedDescription)
            return nil
        }
    }
    
    func deleteFavoriteCoin(by entity: CoinEntity){
        favoriteCoinService.removeFavoriteCoin(entity: entity) { hasDeleted in
            if hasDeleted{
                logInfo(" Coin Deleted sucessfully")
            }else {
                logError("Coin not deleted")
            }
        }
    }
    
    private func sortCoins() {
        switch sortOption {
        case .highestPrice:
            coinList.sort { ($0.price.toDouble()) > ($1.price.toDouble()) }
        case .best24hChange:
            coinList.sort { ($0.change.toDouble()) > ($1.change.toDouble()) }
        }
        onDataUpdated?()
    }
}
