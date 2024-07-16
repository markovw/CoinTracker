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

struct GridView<Content: View>: View { // generic
    @EnvironmentObject var viewModel: MarketRowModel
    
    let content: () -> Content
    
    let columns: [GridItem] = [
        .init(.flexible(minimum: 20, maximum: 30), alignment: .center),
        .init(.flexible(minimum: 130), alignment: .leading),
        .init(.flexible(minimum: 80), alignment: .trailing),
        .init(.flexible(minimum: 60), alignment: .trailing)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            Text("#")
                .onTapGesture {
                    Task {
                        await viewModel.sortByMarketCap()
                    }
                }
            Text("Market cap")
            Text("Price")
                .onTapGesture {
                    Task {
                        await viewModel.sortByPrice()
                    }
                }
            Text("24h %")
            
            content()
        }
        .font(.caption)
        .padding()
    }
}


