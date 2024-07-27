//
//  TickerList.swift
//  CoinTracker
//
//  Created by Vladislav on 27.07.2024.
//

import SwiftUI

struct TickerList: View {
    var tickers: [Ticker]
    
    var body: some View {
        List(tickers) { ticker in
            NavigationLink(destination: MarketDetail(ticker: ticker)) {
                HStack {
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
                                .font(.headline)
                        }
                    }
                    .padding(.vertical, 10)
                    
                    Spacer()
                    
                    Text(ticker.currentPrice.toCurrency() + " $") // ticker price
                        .fontWeight(.medium)
                        .font(.subheadline)
                    
                    HStack { // 24h percentage
                        Triangle(ticker: ticker)
                        Text(ticker.priceChangePercentage24H.toPercentString())
                    }
                    .font(.footnote)
                }
            }
            .listStyle(.inset)
        }
    }
}

#Preview {
    TickerList(tickers: Ticker.exampleTickers)
}

//struct TickerList<Content: View>: View { // generic
//    @EnvironmentObject var viewModel: MarketRowModel
//
//    let content: () -> Content
//
//    let columns: [GridItem] = [
//        .init(.flexible(minimum: 20, maximum: 30), alignment: .center),
//        .init(.flexible(minimum: 130), alignment: .leading),
//        .init(.flexible(minimum: 80), alignment: .trailing),
//        .init(.flexible(minimum: 60), alignment: .trailing)
//    ]
//
//    var body: some View {
//        LazyVGrid(columns: columns, spacing: 20) {
//            Text("#")
//                .onTapGesture {
//                    Task {
//                        await viewModel.sortByMarketCap()
//                    }
//                }
//            Text("Market cap")
//            Text("Price")
//                .onTapGesture {
//                    Task {
//                        await viewModel.sortByPrice()
//                    }
//                }
//            Text("24h %")
//
//            content()
//        }
//        .font(.caption)
//        .padding()
//    }
//}
