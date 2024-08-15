//
//  SearchList.swift
//  CoinTracker
//
//  Created by Vladislav on 15.06.2024.
//

import SwiftUI

struct MarketSearch: View {
    @State private var searchTerm = ""
    @EnvironmentObject var viewModel: MarketRowModel
    @FocusState private var isSearchFocused: Bool
    
    var filteredTickers: [Ticker] {
        guard !searchTerm.isEmpty else { return viewModel.tickers }
        return viewModel.tickers.filter { ticker in
            ticker.id.localizedCaseInsensitiveContains(searchTerm) ||
            ticker.symbol.localizedCaseInsensitiveContains(searchTerm) ||
            ticker.name.localizedCaseInsensitiveContains(searchTerm)
        }
    }
    
    var body: some View {
        NavigationStack {
            CustomSearchBar(searchTerm: $searchTerm)
                .focused($isSearchFocused)
                .padding(.vertical)
            
            withAnimation(.spring(duration: 0.5)) {
                TickerList(tickers: filteredTickers)
            }
        }
        .refreshable {
            do {
                await viewModel.fetchTickers()
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchTickers()
            }
        }
    }
}
