//
//  CoinTrackerApp.swift
//  CoinTracker
//
//  Created by Vladislav on 04.06.2024.
//

import SwiftUI

@main
struct CoinTrackerApp: App {
    @StateObject private var favorites = Favorites()
    @StateObject private var viewModel = MarketRowModel()
        
    var body: some Scene {
        WindowGroup {
            MarketTab()
                .environmentObject(favorites)
                .environmentObject(viewModel)
        }
    }
}
