//
//  Coin+Extension.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 28/02/2025.
//

import Foundation

extension Coin {
    init(from entity: CoinEntity) {
        let uuid = entity.uuid
        let name = entity.name ?? ""
        let symbol = entity.symbol ?? ""
        let price = entity.price ?? ""
        let btcPrice = entity.btcPrice ?? ""
        let marketCap = entity.marketCap ?? ""
        let change = entity.change ?? ""
        let rank = Int(entity.rank ?? "0") ?? 0
        let iconUrl = entity.iconUrl ?? ""
        
        var sparkline: [String] = []
        if let sparklineData = entity.sparkline {
            sparkline = (try? JSONDecoder().decode([String].self, from: sparklineData)) ?? []
        }

        self.init(
            uuid: uuid,
            name: name,
            symbol: symbol,
            price: price,
            btcPrice: btcPrice,
            marketCap: marketCap,
            change: change,
            rank: rank,
            sparkline: sparkline,
            iconUrl: iconUrl
        )
    }
}
