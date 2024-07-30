//
//  Double.swift
//  CoinTracker
//
//  Created by Vladislav on 17.06.2024.
//

import SwiftUI

extension Double {
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .decimal
        return formatter
    }
    
    private var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    func toCurrency() -> String {
        let formatter = currencyFormatter
        if self < 1 {
            formatter.minimumFractionDigits = 4
            formatter.maximumFractionDigits = 4
        } else {
            formatter.minimumFractionDigits = 2
            formatter.maximumFractionDigits = 2
        }
        
        return currencyFormatter.string(for: self) ?? "0.00 $"
    }
    
    func toPercentString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        guard let numberAsString = numberFormatter.string(for: abs(self)) else { return "" }
        return numberAsString + "%"
    }
    
    func toMarketCap() -> String {
        return String(format: "%.2f", self)
    }
    
    func toCapitalization() -> String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""
        
        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.toMarketCap()
            return "\(sign)\(stringFormatted) $ T"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.toMarketCap()
            return "\(sign)\(stringFormatted) $ B"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.toMarketCap()
            return "\(sign)\(stringFormatted) $ M"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.toMarketCap()
            return "\(sign)\(stringFormatted) $ K."
        case 0...:
            return self.toMarketCap()
            
        default:
            return "\(sign)\(self)"
        }
    }
}
