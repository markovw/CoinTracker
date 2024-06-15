//
//  ContentView.swift
//  CoinTracker
//
//  Created by Vladislav on 04.06.2024.
//

import SwiftUI

struct MarketTab: View {
    
    var body: some View {
        TabView {
            MarketRow()
                .tabItem { Label("Markets", systemImage: "house") }
            MarketSearch()
                .tabItem { Label("Search", systemImage: "magnifyingglass") }
            MarketPortfolio()
                .tabItem { Label("Portfolio", systemImage: "case") }
        }
    }
}

#Preview {
    MarketTab()
}
