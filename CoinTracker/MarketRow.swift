//
//  Testttt.swift
//  CoinTracker
//
//  Created by Vladislav on 14.06.2024.
//

import SwiftUI

struct MarketRow: View {
    @State private var tickers: [Ticker] = []
    @State private var isLoading = true
    
    let columns: [GridItem] = [
        .init(.flexible(maximum: 30), spacing: 10, alignment: .center),
        .init(.flexible(maximum: 120), spacing: 60),
        .init(.flexible(maximum: 80), spacing: 30, alignment: .trailing),
        .init(.flexible(maximum: 70), alignment: .trailing)]
    
    
    var body: some View {
        VStack {
            if isLoading {
                Text("Loading...")
            } else if tickers.isEmpty {
                Text("No data available")
            } else {
                LazyVGrid(columns: columns, spacing: 20) {
                    
                    Text("#")
                    Text("Market cap")
                    Text("Price")
                    Text("24h %")
                    
                    ForEach(tickers) { ticker in
                        
                        Text("\(ticker.marketCapRank)")
                            .font(.subheadline)
                        
                        HStack {
                            AsyncImage(url: URL(string: ticker.image)) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                }
                            }
                            VStack(alignment: .leading) {
                                Text(ticker.symbol.uppercased())
                                Text("1,39 T")
//                                Text("\(String(format: "%.2f", ticker.marketCap / 1000000000)) $ B")
                            }
                        }
                        
                        Text("\(formatPrice(ticker.currentPrice)) $")
                            .fontWeight(.medium)
                            .font(.subheadline)
                        
                        Text("graph")
                    }
                }
                .font(.caption)
                
                //                Spacer()
            }
        }
        .onAppear {
            Task {
                await fetchTickers()
            }
        }
    }
    
    private func formatPrice(_ price: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 4
        return formatter.string(from: NSNumber(value: price)) ?? "\(price)"
    }
    
    private func fetchTickers() async {
        let networkManager = NetworkManager()
        do {
            let fetchedTickers = try await networkManager.loadData()
            tickers = fetchedTickers
        } catch {
            print("Failed to fetch tickers: \(error)")
        }
        isLoading = false
    }
}

#Preview {
    MarketRow()
}
