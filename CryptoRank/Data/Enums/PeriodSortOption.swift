//
//  PeriodSortOption.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 27/02/2025.
//


enum PeriodSortOption: CaseIterable, Equatable, Hashable {
    case oneHour
    case oneDay
    case sevenDays
    case thirtyDays
    case threeMonths
    case oneYear
    
    var displayName: String {
        switch self {
        case .oneHour:
            return .localizable(.oneHour)
        case .oneDay:
            return .localizable(.oneDay)
        case .sevenDays:
            return .localizable(.sevenDays)
        case .thirtyDays:
            return .localizable(.thirtyDays)
        case .threeMonths:
            return .localizable(.threeMonths)
        case .oneYear:
            return .localizable(.oneYear)
        }
    }
}
