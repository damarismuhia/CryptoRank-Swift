//
//  CoinHistory.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 26/02/2025.
//

import Foundation

struct CoinHistoryAPIResponse: Decodable {
    let status: String
    let message: String?
    let data: CoinHistory
}

struct CoinHistory: Decodable {
    let history: [CoinHistoryData]
}

struct CoinHistoryData: Decodable {
    let price: String
    let timestamp: TimeInterval
}


