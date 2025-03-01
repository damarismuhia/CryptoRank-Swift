//
//  CoinNetworkManager.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 25/02/2025.
//

import Foundation

class CoinNetworkManager: CoinNetworkManagerProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchData<T>(with request: URLRequest, completionHandler: @escaping (T?, String?) -> Void) where T : Decodable {
        
        session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, error?.localizedDescription)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode) else {
                completionHandler(nil, AppError.failedRequest.errorDescription)
                return
            }
            if let jsonString = String(data: data , encoding: .utf8){
                logInfo("JSON RESPONSE:: \(jsonString)")
            }
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                completionHandler(response, nil)
            }catch {
                logError(error)
                completionHandler(nil, error.localizedDescription)
            }
        }.resume()
        
    }


}


