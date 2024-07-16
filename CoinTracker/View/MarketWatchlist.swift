//
//  PortfolioLIst.swift
//  CoinTracker
//
//  Created by Vladislav on 15.06.2024.
//

import SwiftUI

struct MarketWatchlist: View {
    @EnvironmentObject var favorites: Favorites
    @EnvironmentObject var viewModel: MarketRowModel
    
    var body: some View {
        // list of favorites
        NavigationStack {
            ScrollView {
                GridView {
                    ForEach(viewModel.filteredTickers(favorites: favorites)) { ticker in
                        TickerRow(ticker: ticker)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Watchlist").font(.title2.bold())
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
    MarketWatchlist()
        .environmentObject(MarketRowModel())
}
