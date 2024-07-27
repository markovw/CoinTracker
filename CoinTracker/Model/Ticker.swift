//
//  Ticker.swift
//  CoinTracker
//
//  Created by Vladislav on 05.06.2024.
//

import SwiftUI

struct Ticker: Codable, Identifiable {
    var id: String
    var symbol: String
    var name: String
    var image: String
    var currentPrice: Double
    var marketCap: Double
    var marketCapRank: Int
    var marketCapChangePercentage24H: Double
    var priceChangePercentage24H: Double
}

extension Ticker {
    static func sortedByMarketCapRankDescending(_ tickers: [Ticker]) -> [Ticker] {
        return tickers.sorted { $0.marketCapRank > $1.marketCapRank }
    }
}

extension Ticker {
    static var exampleTickers: [Ticker] {
        [
            Ticker(id: "bitcoin", symbol: "BTC", name: "BTC", image: "bitcoinlogo", currentPrice: 64000, marketCap: 1.36, marketCapRank: 1, marketCapChangePercentage24H: 2.07, priceChangePercentage24H: 2.25)
        ]
    }
}
