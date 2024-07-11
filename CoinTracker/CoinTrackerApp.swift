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
    
    var body: some Scene {
        WindowGroup {
            MarketTab()
                .environmentObject(favorites)
        }
    }
}
