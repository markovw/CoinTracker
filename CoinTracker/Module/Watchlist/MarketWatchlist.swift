//
//  PortfolioLIst.swift
//  CoinTracker
//
//  Created by Vladislav on 15.06.2024.
//

import SwiftUI

struct MarketWatchlist: View {
    @EnvironmentObject var favorites: FavoritesViewModel
    @EnvironmentObject var viewModel: MarketRowViewModel
    
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
        .background(Color("backgroundColor"))
    }
}

#Preview {
    MarketWatchlist()
        .environmentObject(MarketRowViewModel())
}
