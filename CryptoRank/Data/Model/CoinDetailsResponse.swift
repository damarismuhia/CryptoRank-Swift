//
//  CoinDetails.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 27/02/2025.
//


struct CoinDetailsResponse: Decodable {
    let status: String
    let message: String?
    let data: CoinData
}

struct CoinData: Decodable {
    let coin: CoinDetailsData
}


struct CoinDetailsData: Decodable {
    let uuid: String
    let name: String
    let symbol: String
    let rank: Int
    let price: String
    let change: String
    let marketCap: String
    let volume: String // 24hVolume
    let fullyDilutedMarketCap: String
    let description: String
    let numberOfMarkets: Int
    let numberOfExchanges: Int

    private enum CodingKeys: String, CodingKey {
        case uuid, name, symbol, rank, price, change
        case marketCap, fullyDilutedMarketCap, description
        case numberOfMarkets, numberOfExchanges
        case volume = "24hVolume"
    }
}


