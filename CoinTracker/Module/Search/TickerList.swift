//
//  TickerList.swift
//  CoinTracker
//
//  Created by Vladislav on 27.07.2024.
//

import SwiftUI
import Kingfisher

struct TickerList: View {
    var tickers: [Ticker]
    
    var body: some View {
        List(tickers) { ticker in
            NavigationLink(destination: MarketDetail(ticker: ticker)) {
                HStack {
                    HStack(spacing: 8) { // ticker + marketcap

                        KFImage(URL(string: ticker.image))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(ticker.symbol.uppercased()).fontWeight(.medium)
                                .font(.headline)
                        }
                    }
                    .padding(.vertical)
                    
                    Spacer()
                    
                    Text(ticker.currentPrice.toCurrency() + " $") // ticker price
                        .fontWeight(.medium)
                        .font(.subheadline)
                    
                    HStack { // 24h percentage
                        PriceChangeTriangle(ticker: ticker)
                        Text(ticker.priceChangePercentage24H.toPercentString())
                    }
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundColor(ticker.priceChangePercentage24H < 0 ? .red : .green)
                }
            }
            .listStyle(.inset)
        }
    }
}

#Preview {
    TickerList(tickers: Ticker.exampleTickers)
}
