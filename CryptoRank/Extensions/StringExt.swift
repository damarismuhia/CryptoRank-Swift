//
//  StringExt.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 24/02/2025.
//

import Foundation
import UIKit
extension String {
    func toUrl() -> URLComponents? {
        return URLComponents(string: self)
    }
    func formatPrice(to fractionDigits: Int = 2) -> String {
        guard let number = Double(self) else { return "" }

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = fractionDigits
        formatter.minimumFractionDigits = 0
        let formated = formatter.string(from: NSNumber(value: number)) ?? self
        return "$\(formated)"
    }
    
    func formatHrChange() -> String{
        return self.appending("%")
    }
    
    func formatMarketCap() -> String {
        guard let number = Double(self) else { return self }
        switch number {
        case 1_000_000_000_000.0...:
                return String(format: "%.2fT", number / 1_000_000_000_000)
        case 1_000_000_000.0...:
                return String(format: "%.2fB", number / 1_000_000_000)
        case 1_000_000.0...:
                return String(format: "%.2fM", number / 1_000_000)
            default:
                return String(format: "%.2f", number)
        }
    }
    func formatBTCPrice() -> String {
        guard let value = Double(self) else { return self }
        
        switch value {
        case 1...:
            return String(format: "%.0f BTC", value)
        case 0.000001...:
            return String(format: "%.6f BTC", value)
        default:
            return String(format: "%.2e BTC", value)
        }
    }
    
    func dropcommas() -> String {
        return self.replacingOccurrences(of: ",", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
   }
   func toDouble() -> Double {
       return Double(self.dropcommas()) ?? 0.00
   }

    
    func setCoinTitle(rangeTwo: String)
    -> NSMutableAttributedString {
        let fullText = "\(self) \(rangeTwo) "
        let attributedString = NSMutableAttributedString(string: fullText)
        
        let onRangeTwo = (fullText as NSString).range(of: rangeTwo)
        attributedString.addAttribute(.font, value: UIFont.sourceSanLight(12), range: onRangeTwo)
        attributedString.addAttribute(.baselineOffset, value: -2, range: onRangeTwo)
        return attributedString
    }
    
}
