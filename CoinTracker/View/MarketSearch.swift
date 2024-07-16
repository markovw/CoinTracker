//
//  SearchList.swift
//  CoinTracker
//
//  Created by Vladislav on 15.06.2024.
//

import SwiftUI

struct MarketSearch: View {
    @State private var searchTerm = ""
    @State private var tickers: [Ticker] = []
    
    var filteredTickers: [Ticker] {
        guard !searchTerm.isEmpty else { return tickers }
        return tickers.filter { $0.name.localizedCaseInsensitiveContains(searchTerm)}
    }
    
    var body: some View {
        NavigationStack {
            List {
                ZStack {

                }
                
            }
        }
        .searchable(text: $searchTerm, prompt: "Search coins")
    }
}

