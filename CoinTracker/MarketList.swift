//
//  ContentView.swift
//  CoinTracker
//
//  Created by Vladislav on 04.06.2024.
//

import SwiftUI

struct MarketList: View {
    var body: some View {
        NavigationStack {
            NavigationLink {
                MarketDetail()
            } label: {
                MarketRow()
            }
        }
    }
}

#Preview {
    MarketList()
}
