//
//  AppError.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 25/02/2025.
//

import Foundation

enum AppError: LocalizedError {
    case failedRequest
    case decodingError
    
    var errorDescription: String? {
        switch self {
        case .failedRequest:
            return .localizable(.defaultError)
        case .decodingError:
            return .localizable(.decodingError)
        }
    }
}
