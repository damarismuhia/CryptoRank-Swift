//
//  CoinsTableViewCell.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 25/02/2025.
//

import UIKit
import SDWebImageSVGCoder
import DGCharts

class CoinsTableViewCell: UITableViewCell {
    static let identifier = "CoinsTableViewCell"
    private lazy var mainView: UIView = {
        let vw = UIView()
        vw.layer.cornerRadius = 8
        vw.backgroundColor = .cardBackground
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()
    
    private lazy var logoCircularView: UIView = {
        let vw = UIView()
        vw.layer.cornerRadius = 8
        vw.backgroundColor = .background
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()
    
    private lazy var logoImg: UIImageView = {
        let iv = UIImageView(uiImage: .logo)
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var coinTitleLb: UILabel = {
        return UILabel(font: .sourceSanMedium())
    }()
    private lazy var coinSymbolLb: UILabel = {
        return UILabel(font: .boldSystemFont(ofSize: 12), textColor: .darkGrey)
    }()
    private lazy var coinTitleStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [coinTitleLb, coinSymbolLb])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis  = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        return sv
    }()
    private lazy var priceLb: UILabel = {
        return UILabel(font: .sourceSanRegular())
    }()
    
    private lazy var hrPerformanceLB: UILabel = {
        return UILabel(font: .sourceSanRegular())
    }()
        

        
    private lazy var priceStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [priceLb, hrPerformanceLB])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis  = .vertical
        sv.alignment = .trailing
       // sv.backgroundColor = .cyan
        sv.distribution = .fill
        return sv
    }()
    private lazy var lineChartView: LineChartView = {
           let chartView = LineChartView()
           chartView.translatesAutoresizingMaskIntoConstraints = false
           chartView.legend.enabled = false
           chartView.xAxis.enabled = false
           chartView.leftAxis.enabled = false
           chartView.rightAxis.enabled = false
           chartView.setScaleEnabled(true)
           chartView.dragEnabled = false
           chartView.highlightPerTapEnabled = true
           chartView.highlightPerDragEnabled = true
           chartView.drawGridBackgroundEnabled = false
           return chartView
       }()
    
    private lazy var mainStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [coinTitleStack,lineChartView, priceStack])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis  = .horizontal
        sv.spacing = 8
        sv.alignment = .fill
        sv.distribution = .fill
        return sv
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private func setUpViews(){
        contentView.addSubview(mainView)
        backgroundColor = .clear
        mainView.addSubview(logoImg)
        mainView.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10),
            
            logoImg.heightAnchor.constraint(equalToConstant: CacheKeys.IMAGE_SIZE),
            logoImg.widthAnchor.constraint(equalToConstant: CacheKeys.IMAGE_SIZE),
            logoImg.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            logoImg.leadingAnchor.constraint(equalTo: mainView.leadingAnchor,constant: 5),

            mainStack.topAnchor.constraint(equalTo: mainView.topAnchor,constant: 8),
            mainStack.bottomAnchor.constraint(equalTo: mainView.bottomAnchor,constant: -8),
            mainStack.leadingAnchor.constraint(equalTo: logoImg.trailingAnchor,constant: 8),
            mainStack.trailingAnchor.constraint(equalTo: mainView.trailingAnchor,constant: -8),
                    
        ])
        lineChartView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        lineChartView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        coinTitleStack.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        coinTitleStack.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        priceStack.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        priceStack.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        
    }
    
    func configureCoinData(with coin: Coin){
        coinTitleLb.text = coin.name
        coinSymbolLb.text = coin.symbol
        priceLb.text = coin.price.formatPrice()
        hrPerformanceLB.text = coin.change.formatHrChange()
        hrPerformanceLB.textColor = coin.change.starts(with: "-") ? .red : .darkGreen
        logoImg.setupImageView(with: coin.iconUrl)
        
        if let dataSet = ChartDataConverter.convertToChartEntries(sparkline: coin.sparkline ?? []) {
            lineChartView.data = LineChartData(dataSet: dataSet)
        }
            
    }  

}
