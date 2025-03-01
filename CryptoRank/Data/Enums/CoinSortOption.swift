//
//  CoinSortOption.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 28/02/2025.
//


enum CoinSortOption: CaseIterable {
    case highestPrice
    case best24hChange
    
    var displayName: String {
        switch self {
        case .highestPrice: return .localizable(.highPrice)
        case .best24hChange: return .localizable(.best24Hr)
        }
    }
}
