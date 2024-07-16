//
//  MarketRowModel.swift
//  CoinTracker
//
//  Created by Vladislav on 17.06.2024.
//

import SwiftUI

@MainActor class MarketRowModel: ObservableObject {
    @Published var tickers: [Ticker] = []
    @Published var isLoading = true
    
    func fetchTickers() async {
        let networkManager = NetworkManager()
        do {
            let fetchedTickers = try await networkManager.loadData()
            tickers = fetchedTickers
            isLoading = false
        } catch {
            print("Failed to fetch tickers: \(error)")
        }
    }
    
    func filteredTickers(favorites: Favorites) -> [Ticker] {
        return tickers.filter { favorites.contains($0) }
    }
}
