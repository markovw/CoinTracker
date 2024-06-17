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
            ScrollView {
                ZStack {
                    if isLoading {
                        ProgressView() {
                            Text("Loading...")
                        }
                        .offset(y: 250)
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    } else if tickers.isEmpty {
                        Text("No data available. Try to refresh the page. If it doesn't work, notify the support.")
                    } else {
                        
                        LazyVGrid(columns: columns, spacing: 20) {
                            Text("#")
                            Text("Market cap")
                            Text("Price")
                            Text("24h %")
                            
                            ForEach(tickers) { ticker in
                                TickerRow(ticker: ticker)
                            }
                        }
                        .font(.caption)
                        .padding()
                        
                    }
                }
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
        .onAppear {
            Task {
                await fetchTickers()
            }
        }
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
