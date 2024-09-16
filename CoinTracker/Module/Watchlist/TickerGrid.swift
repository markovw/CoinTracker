//
//  TickerGrid.swift
//  CoinTracker
//
//  Created by Vladislav on 27.07.2024.
//

import SwiftUI

struct GridView<Content: View>: View { // generic
    @EnvironmentObject var viewModel: MarketRowViewModel
    
    let content: () -> Content
    
    let columns: [GridItem] = [
        .init(.flexible(minimum: 20, maximum: 30), alignment: .center),
        .init(.flexible(minimum: 130), alignment: .leading),
        .init(.flexible(minimum: 80), alignment: .trailing),
        .init(.flexible(minimum: 60), alignment: .trailing)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            Text("#")
                .onTapGesture {
                    Task {
                        await viewModel.sortByMarketCap()
                    }
                }
            
            Text("Market cap")
            Text("Price")
                .onTapGesture {
                    Task {
                        await viewModel.sortByPrice()
                    }
                }
            Text("24h %")
            
            content()
        }
        .font(.caption)
        .padding()
    }
}
