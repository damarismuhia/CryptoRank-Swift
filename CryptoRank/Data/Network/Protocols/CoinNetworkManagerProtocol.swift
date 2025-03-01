//
//  CoinNetworkManagerProtocol.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 25/02/2025.
//

import Foundation

protocol CoinNetworkManagerProtocol: AnyObject {
    func fetchData<T: Decodable>(with request: URLRequest, completionHandler: @escaping (T?, String?) -> Void)
}

