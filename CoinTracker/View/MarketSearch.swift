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
    
    var filteredTickers: [Ticker] {
        guard !searchTerm.isEmpty else { return viewModel.tickers }
        return viewModel.tickers.filter { $0.name.localizedCaseInsensitiveContains(searchTerm) }
    }
    
    var body: some View {
        NavigationStack {
            TickerList(tickers: filteredTickers)
        }
        .onAppear {
            Task {
                await viewModel.fetchTickers()
            }
        }
        .searchable(text: $searchTerm, prompt: "Search coins")
    }
}
