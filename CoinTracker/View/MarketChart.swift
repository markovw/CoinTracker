//
//  MarketChart.swift
//  CoinTracker
//
//  Created by Vladislav on 16.06.2024.
//

import SwiftUI

struct MarketChart: View {
    var body: some View {
        Rectangle() // chart view
            .frame(width: UIScreen.main.bounds.width - 20, height: 300)
            .opacity(0.1)
            .overlay {
                Text("Graph View")
            }
    }
}

#Preview {
    MarketChart()
}
