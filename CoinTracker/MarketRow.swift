//
//  MarketRow.swift
//  CoinTracker
//
//  Created by Vladislav on 05.06.2024.
//

import SwiftUI

struct MarketRow: View {
    @State private var ticker: Ticker?
    @State private var isLoading = true
    
    var body: some View {
        List {
            if isLoading {
                Text("Loading...")
            } else if let ticker = ticker {
                HStack {
                    Text("#")
                    Text("Market cap")
                        .padding(.trailing, 125)
                    Text("Price")
                        .padding(.trailing, 50)
                    Text("24h %")
                }
                .font(.caption)
                
                HStack {
                    Text("\(ticker.marketCapRank)")
                    
                    AsyncImage(url: URL(string: ticker.image)) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text(ticker.symbol.uppercased())
                            .fontWeight(.medium)
                            .font(.caption)
                            .padding(.bottom, 3)
                            
                        Text("$1,39 T")
                            .font(.caption)
                    }
                    .padding(.leading, -5)
                    .padding(.trailing, 80)

                    Text("\(ticker.currentPrice.formatted(.number)) $")
                        .fontWeight(.medium)
                        .font(.subheadline)
                }
                .padding(.bottom, 5)
            } else {
                Text("Failed to load data")
            }
            
        }
        .listStyle(.plain)
        .onAppear {
            Task {
                await fetchTicker()
            }
        }
    }
    private func fetchTicker() async {
        let networkManager = NetworkManager()
        do {
            let fetchedTicker = try await networkManager.loadData()
            ticker = fetchedTicker
        } catch {
            print("Failed to fetch ticker: \(error)")
        }
        isLoading = false
    }
}

#Preview {
    MarketRow()
}
