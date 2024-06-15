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
        .init(.flexible(minimum: 20, maximum: 30), alignment: .center),
        .init(.flexible(minimum: 130), alignment: .leading),
        .init(.flexible(minimum: 80), alignment: .trailing),
        .init(.flexible(minimum: 60), alignment: .trailing)]
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                if isLoading {
                    ProgressView() {
                        Text("Loading...")
                    }
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    
                } else if tickers.isEmpty {
                    Text("No data available. Notify the support")
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            Text("#")
                            Text("Market cap")
                            Text("Price")
                            Text("24h %")
                            
                            ForEach(tickers) { ticker in
                                Text("\(ticker.marketCapRank)")
                                    .font(.subheadline)
                                
                                NavigationLink(destination: MarketDetail(ticker: ticker)) {
                                    HStack(spacing: 8) {
                                        AsyncImage(url: URL(string: ticker.image)) { phase in
                                            if let image = phase.image {
                                                image
                                                    .resizable()
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
                                
                                Text("\(formatPrice(ticker.currentPrice)) $")
                                    .fontWeight(.medium)
                                    .font(.subheadline)
                                
                                Text("\(String(format: "%.2f", ticker.priceChangePercentage24H)) %")
                            }
                        }
                        .font(.caption)
                        .padding()
                    }
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Text("Markets").font(.title2.bold())
                        }
                    }
                    .refreshable {
                        await fetchTickers()
                    }
                }
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
