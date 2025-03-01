//
//  PerformanceChartView.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 26/02/2025.
//

import SwiftUI
import Charts
import DGCharts




struct PerformanceChartView: UIViewRepresentable {
    let entry: [ChartDataEntry]
    let selectedPeriod: PeriodSortOption
    func makeUIView(context: Context) -> LineChartView {
        let chartView = LineChartView()
        
        let yAxis = chartView.rightAxis
        let xAxis = chartView.xAxis
        yAxis.enabled = true
        yAxis.axisLineColor = .clear
        yAxis.drawGridLinesEnabled = true
        chartView.leftAxis.enabled = false
        xAxis.labelPosition = .bottom
        xAxis.drawGridLinesEnabled = false
        xAxis.valueFormatter = DateValueFormatter(period: selectedPeriod)
        xAxis.labelRotationAngle = 25.0
        chartView.animate(xAxisDuration: 0.5)
        chartView.highlightPerTapEnabled = true
        chartView.highlightPerDragEnabled = true
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = true
        chartView.xAxis.granularity = 2
        chartView.dragXEnabled = true
        
        
        return chartView
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        let dataSet = LineChartDataSet(entries: entry, label: "Coin Price")
        dataSet.mode = .cubicBezier
        dataSet.lineWidth = 0.8
        dataSet.setColor(.primaryDark)
        dataSet.drawCirclesEnabled = false
        
        let gradientColors = [UIColor.primaryApp.cgColor, UIColor.clear.cgColor] as CFArray
            let colorLocations: [CGFloat] = [1.0, 0.0]
            if let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) {
                dataSet.fill = LinearGradientFill(gradient: gradient, angle: 90.0)
                dataSet.drawFilledEnabled = true
            }
        
        let data = LineChartData(dataSet: dataSet)
        data.setDrawValues(false)
        uiView.data = data
        uiView.xAxis.valueFormatter = DateValueFormatter(period: selectedPeriod)
        uiView.moveViewToX(Double(entry.count - 1))
        
        
    }
    
    
    
}

#Preview {
    let history: [CoinHistoryData] = [
        CoinHistoryData(price: "87783.59", timestamp: 1740583800),
        CoinHistoryData(price: "87929.01", timestamp: 1740583500),
        CoinHistoryData(price: "88138.08", timestamp: 1740583200),
        CoinHistoryData(price: "88120.12", timestamp: 1740582900),
        CoinHistoryData(price: "87762.02", timestamp: 1740582600),
        CoinHistoryData(price: "87666.67", timestamp: 1740582300),
        CoinHistoryData(price: "87371.65", timestamp: 1740582000),
        ]

    PerformanceChartView(entry: ChartDataConverter.toChartDataEntry(entries: history), selectedPeriod: .oneDay)
}
