//
//  CoinTrackerApp.swift
//  CoinTracker
//
//  Created by Vladislav on 04.06.2024.
//

import SwiftUI

@main
struct CoinTrackerApp: App {
    @StateObject private var favorites = FavoritesViewModel()
    @StateObject private var viewModel = MarketRowViewModel()
        
    var body: some Scene {
        WindowGroup {
            LoginScreen()
                .environmentObject(favorites)
                .environmentObject(viewModel)
        }
    }
}
