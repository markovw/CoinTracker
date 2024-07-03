//
//  Testttt.swift
//  CoinTracker
//
//  Created by Vladislav on 14.06.2024.
//

import SwiftUI

struct MarketRow: View {
    @StateObject var viewModel = MarketRowModel()
    
    let columns: [GridItem] = [
        .init(.flexible(minimum: 20, maximum: 30), alignment: .center),
        .init(.flexible(minimum: 130), alignment: .leading),
        .init(.flexible(minimum: 80), alignment: .trailing),
        .init(.flexible(minimum: 60), alignment: .trailing)]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ZStack {
                    if viewModel.isLoading {
                        ProgressView() {
                            Text("Loading...")
                        }
                        .offset(y: 250)
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    } else if viewModel.tickers.isEmpty {
                        Text("No data available. Try to refresh the page. If it doesn't work, notify the support.")
                    } else {
                        LazyVGrid(columns: columns, spacing: 20) {
                            Text("#")
                            Text("Market cap")
                            Text("Price")
                            Text("24h %")
                            
                            ForEach(viewModel.tickers) { ticker in
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
                await viewModel.fetchTickers()
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchTickers()
            }
        }
    }
    
//    private func fetchTickers() async {
//        let networkManager = NetworkManager()
//        do {
//            let fetchedTickers = try await networkManager.loadData()
//            tickers = fetchedTickers
//            isLoading = false
//        } catch {
//            print("Failed to fetch tickers: \(error)")
//        }
//        
//    }
}

#Preview {
    MarketRow()
}
