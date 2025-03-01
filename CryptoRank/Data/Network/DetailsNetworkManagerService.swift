//
//  DetailsNetworkService.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 27/02/2025.
//

import Foundation

class DetailsNetworkManagerService: DetailsNetworkManagerServiceProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    func fetchRequest<T>(with request: URLRequest) async throws -> T? where T : Decodable {
            let (data, response) = try await session.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                logError("HTTP ERROR: ")
                throw AppError.failedRequest
            }
            
            guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                throw AppError.decodingError
            }
            if let jsonString = String(data: data , encoding: .utf8){
                logInfo("JSON RESPONSE::->:: \(jsonString)")
            }
            return decodedData
    }

    
}
