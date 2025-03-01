//
//  DetailCoinWebService.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 27/02/2025.
//

import Foundation



class DetailCoinWebService: DetailCoinWebServiceProtocol {
  
    let detailNetworkService: DetailsNetworkManagerServiceProtocol
    
    init(detailNetworkService: DetailsNetworkManagerServiceProtocol = DetailsNetworkManagerService()) {
        self.detailNetworkService = detailNetworkService
    }
    func fetchCoinDetails(for coinId: String) async throws -> CoinDetailsResponse? {
        guard let request = URLRequestFactory.createUrlRequest(endpoint: Endpoints.details(uuid: coinId).path) else {
            throw AppError.failedRequest
        }
        return try await detailNetworkService.fetchRequest(with: request)
    }
    
    func fetchCoinHistory(for coinId: String, with timePeriod: String) async throws -> CoinHistoryAPIResponse? {
        guard let request = URLRequestFactory.createUrlRequest(endpoint: Endpoints.history(uuid: coinId).path) else {
            throw AppError.failedRequest
        }
        return try await detailNetworkService.fetchRequest(with: request)
    }
    
    
    
}
