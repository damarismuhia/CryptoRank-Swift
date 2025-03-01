//
//  Endpoints.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 27/02/2025.
//


enum Endpoints {
    case coins
    case details(uuid: String)
    case history(uuid: String)

    var path: String {
        switch self {
        case .coins:
            return "coins"
        case .details(let uuid):
            return "/coin/\(uuid)"
        case .history(let uuid): 
            return "/coin/\(uuid)/history"
        
        }
    }
}
