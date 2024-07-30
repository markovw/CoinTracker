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
                    Text(ticker.marketCap.toCapitalization())
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
        
        Text(ticker.currentPrice.toCurrency() + " $") // ticker price
            .fontWeight(.medium)
            .font(.system(size: 14))
        
        HStack { // 24h percentage
            PriceChangeTriangle(ticker: ticker)
            Text(ticker.priceChangePercentage24H.toPercentString())
                .fontWeight(.medium)
                .foregroundColor(ticker.priceChangePercentage24H < 0 ? .red : .green)
        }
    }
}

#Preview {
    TickerRow(ticker: Ticker(id: "BTC", symbol: "BTC", name: "Bitcoin", image: "", currentPrice: 67000, marketCap: 1.35, marketCapRank: 1, marketCapChangePercentage24H: 1.02, priceChangePercentage24H: 1.05))
}

