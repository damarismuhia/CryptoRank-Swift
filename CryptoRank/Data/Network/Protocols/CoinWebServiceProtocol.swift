//
//  CoinWebServiceProtocol.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 24/02/2025.
//


protocol CoinWebServiceProtocol: AnyObject {
    func fetchCoins(offset: Int, limit: Int, completionHandler: @escaping(CoinResponse?, String?) -> Void)
}
