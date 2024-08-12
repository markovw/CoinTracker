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
    @Published var isMarketCapSorted: Bool = false
    @Published var isPriceSorted: Bool = false
    
    func fetchTickers() async {
        let networkManager = NetworkManager()
        do {
            let fetchedTickers = try await networkManager.loadData()
            withAnimation(.spring(duration: 0.5)) {
                tickers = fetchedTickers
                isLoading = false
            }
        } catch {
            print("Failed to fetch tickers: \(error)")
        }
    }
    
    func sortByMarketCap() async {
        if isMarketCapSorted {
            tickers.sort { $0.marketCapRank < $1.marketCapRank }
            isMarketCapSorted = false
        } else {
            tickers.sort { $0.marketCapRank > $1.marketCapRank }
            isMarketCapSorted = true
        }
    }
    
    func sortByPrice() async {
        if isPriceSorted {
            tickers.sort { $0.currentPrice > $1.currentPrice }
            isPriceSorted = false
        } else {
            tickers.sort { $0.currentPrice < $1.currentPrice }
            isPriceSorted = true
        }
    }
    
    func filteredTickers(favorites: Favorites) -> [Ticker] {
        return tickers.filter { favorites.contains($0) }
    }
}
