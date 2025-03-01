//
//  DateValueFormatter.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 01/03/2025.
//
import Foundation
import DGCharts

class DateValueFormatter: AxisValueFormatter {
    private let dateFormatter = DateFormatter()
    private let period: PeriodSortOption

    init(period: PeriodSortOption) {
        self.period = period
        switch period {
        case .oneHour:
            dateFormatter.dateFormat = "HH:mm"
        case .oneDay:
            dateFormatter.dateFormat = "HH:mm"
        case .sevenDays:
            dateFormatter.dateFormat = "EEE"
        case .thirtyDays:
            dateFormatter.dateFormat = "MMM d"
        case .threeMonths, .oneYear:
            dateFormatter.dateFormat = "MMM yyyy"
        }
    }

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let date = Date(timeIntervalSince1970: value)
        return dateFormatter.string(from: date)
    }
}
