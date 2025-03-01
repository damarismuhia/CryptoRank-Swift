//
//  JSONDecoderHelper.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 25/02/2025.
//

import Foundation
import DGCharts
import UIKit

struct ChartDataConverter {
    static func toChartDataEntry(entries: [CoinHistoryData]) -> [ChartDataEntry] {
        return entries.compactMap { entry in
            guard let price = Double(entry.price) else { return nil }
            return ChartDataEntry(x: entry.timestamp, y: price)
        }
    }
    
    static func convertToChartEntries(sparkline: [String]) -> LineChartDataSet? {
        let filteredData = sparkline.compactMap { $0.toDouble() }
        guard let firstPrice = filteredData.first, let lastPrice = filteredData.last else { return nil }

        let lineColor: UIColor = lastPrice > firstPrice ? .darkGreen : .red
        let entries = filteredData.enumerated().map { index, value in
            ChartDataEntry(x: Double(index), y: value)
        }

        let dataSet = LineChartDataSet(entries: entries, label: "")
        dataSet.drawCirclesEnabled = false
        dataSet.drawValuesEnabled = false
        dataSet.mode = .cubicBezier
        dataSet.drawFilledEnabled = false
        dataSet.lineWidth = 1.5
        dataSet.colors = [lineColor]
        
        return dataSet
    }
}



