//
//  TickerRow.swift
//  CoinTracker
//
//  Created by Vladislav on 17.06.2024.
//

import SwiftUI

struct TickerRow: View {
    let ticker: Ticker
    
    var body: some View {
        Text("\(ticker.marketCapRank)")
            .font(.subheadline)
        
        NavigationLink(destination: MarketDetail(ticker: ticker)) {
            HStack(spacing: 8) { // ticker + marketcap
                AsyncImage(url: URL(string: ticker.image)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                }
                VStack(alignment: .leading, spacing: 5) {
                    Text(ticker.symbol.uppercased()).fontWeight(.medium)
                    Text("\(String(format: "%.2f", ticker.marketCap / 1000000000)) $ B").lineLimit(1)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
        
        Text(ticker.currentPrice.toCurrency() + " $") // ticker price
            .fontWeight(.medium)
            .font(.subheadline)

        HStack { // 24h percentage
            Image(systemName: ticker.priceChangePercentage24H < 0 ? "triangle.fill" : "triangle.fill")
                .imageScale(.small)
                .foregroundStyle(ticker.priceChangePercentage24H < 0 ? .red : .green)
                .rotationEffect(ticker.priceChangePercentage24H < 0 ? .degrees(180): .degrees(0))
            Text(ticker.priceChangePercentage24H.toPercentString())
        }
    }
}

