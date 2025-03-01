//
//  MockDataProvider.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 01/03/2025.
//

import Foundation


class MockDataProvider {
    static func mockCoinResponseJSON() -> Data? {
        let jsonString =
            """
            {
            "status": "success",
            "data": {
            "coins": [
                { "uuid": "123", "name": "Bitcoin", "symbol": "BTC", "price": "48.9995", "btcPrice": "0.0277698940045","marketCap": "567897890", "change": "3.15", "rank": 1 , "sparkline": ["86944.84266674308","86950.23738915377","87323.79635020104","87249.56924869833"], "iconUrl": "https://cdn.coinranking.com/bOabBYkcX/bitcoin_btc.svg"},
                { "uuid": "ethereum3", "name": "Ethereum", "symbol": "ETH", "price": "48.9995", "btcPrice": "0.0277698940045","marketCap": "567897890","change": "3.15", "rank": 2 , "sparkline": ["86944.84266674308","86950.23738915377","87323.79635020104","87249.56924869833"], "iconUrl": "https://cdn.coinranking.com/bOabBYkcX/bitcoin_btc.svg"}
                ]
             }
            }
            """
        return jsonString.data(using: .utf8)
    }
    
}
