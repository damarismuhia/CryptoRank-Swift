//
//  URLRequestFactory.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 27/02/2025.
//

import Foundation


struct URLRequestFactory {
    static func createUrlRequest(
           endpoint: String,
           httpMethod: String = MethodsType.GET.rawValue,
           queryParams: [String: String] = [:]
       ) -> URLRequest? {
           let urlString = AppConfig.BASE_URL + endpoint
           guard var urlComponents = urlString.toUrl() else { return nil }
           if !queryParams.isEmpty {
               urlComponents.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
           }
           guard let finalUrl = urlComponents.url else { return nil }
           var request = URLRequest(url: finalUrl)
           request.httpMethod = httpMethod
           
           request.addValue("application/json", forHTTPHeaderField: "Accept")
           request.setValue(AppConfig.API_KEY, forHTTPHeaderField: "x-access-token")
           
           return request
       }
 
}
