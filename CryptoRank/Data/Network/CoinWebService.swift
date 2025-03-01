//
//  CoinWebService.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 24/02/2025.
//

import Foundation

class CoinWebService: CoinWebServiceProtocol {
    private let networkService: CoinNetworkManagerProtocol
    init(networkService: CoinNetworkManagerProtocol = CoinNetworkManager()) {
        self.networkService = networkService
    }
    func fetchCoins(offset: Int, limit: Int, completionHandler: @escaping(CoinResponse?, String?) -> Void) {
        let params: [String: String] = [
            "limit":"\(limit)",
            "offset": "\(offset)"
        ]
        guard let request = URLRequestFactory.createUrlRequest(endpoint: Endpoints.coins.path, queryParams: params) else {
            completionHandler(nil, AppError.failedRequest.errorDescription)
            return
        }
        networkService.fetchData(with: request, completionHandler: completionHandler)
    }
}





