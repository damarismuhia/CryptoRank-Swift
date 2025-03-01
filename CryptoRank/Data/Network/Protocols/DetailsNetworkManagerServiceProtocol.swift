//
//  DetailsNetworkManagerServiceProtocol.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 27/02/2025.
//

import Foundation

protocol DetailsNetworkManagerServiceProtocol: AnyObject {
    func fetchRequest<T: Decodable>(with request: URLRequest) async throws -> T?
}
