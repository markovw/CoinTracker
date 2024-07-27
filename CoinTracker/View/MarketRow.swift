//
//  Testttt.swift
//  CoinTracker
//
//  Created by Vladislav on 14.06.2024.
//

import SwiftUI

struct MarketRow: View {
    @EnvironmentObject var viewModel: MarketRowModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if viewModel.isLoading {
                    ProgressView() {
                        Text("Loading...")
                    }
                    .offset(y: 250)
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                } else if viewModel.tickers.isEmpty {
                    Text("No data available. Try to refresh the page. If it doesn't work, notify the support.")
                } else {
                    GridView {
                        ForEach(viewModel.tickers) { ticker in
                            TickerRow(ticker: ticker)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Markets").font(.title2.bold())
                }
            }
            .refreshable {
                do {
                    await viewModel.fetchTickers()
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchTickers()
            }
        }
    }
}

#Preview {
    MarketRow()
}
