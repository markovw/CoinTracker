//
//  SearchList.swift
//  CoinTracker
//
//  Created by Vladislav on 15.06.2024.
//

import SwiftUI
import Lottie

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

// MARK: SearchBar -------------

struct CustomSearchBar: View {
    @Binding var searchTerm: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.primary)
                .padding(.leading, 8)
            
            TextField("Search coins or addresses...", text: $searchTerm)
                .foregroundColor(.primary)
                .accentColor(.primary)
                .autocorrectionDisabled()
            
            Spacer()
            
            if !searchTerm.isEmpty {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 17, height: 17)
                    .padding(.horizontal)
                    .onTapGesture {
                        withAnimation(.easeOut(duration: 0.25)) {
                            searchTerm = ""
                        }
                    }
            }
        }
        .padding(.vertical, 15)
        .background(Color(UIColor.systemGray6))
        .cornerRadius(15)
        .padding(.horizontal)
    }
}

