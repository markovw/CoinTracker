//
//  PortfolioLIst.swift
//  CoinTracker
//
//  Created by Vladislav on 15.06.2024.
//

import SwiftUI

struct MarketWatchlist: View {
    @EnvironmentObject var favorites: Favorites

    
    var body: some View {
        Label("There is will be the crypto watchlist", systemImage: "case")

        // list of favorites
    }
}

#Preview {
    MarketWatchlist()
}
