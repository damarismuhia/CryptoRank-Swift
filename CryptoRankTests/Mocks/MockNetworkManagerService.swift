//
//  MockNetworkManagerService.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 01/03/2025.
//

import XCTest
@testable import CryptoRank
class MockNetworkManagerService: CoinNetworkManagerProtocol {
    var mockData: Data?
    var shouldReturnError: Bool = false
    
    func fetchData<T>(with request: URLRequest, completionHandler: @escaping (T?, String?) -> Void) where T : Decodable {
        if shouldReturnError {
            completionHandler(nil, AppError.failedRequest.errorDescription)
            return
        }
        guard let data = mockData else {
            completionHandler(nil, "No Data Found")
            return
        }
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            completionHandler(decodedData, nil)
        }catch {
            completionHandler(nil, "Decoding mock data failed")
        }
        
    }
    
    
}
