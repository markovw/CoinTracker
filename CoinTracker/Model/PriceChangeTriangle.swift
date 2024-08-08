//
//  Triangle.swift
//  CoinTracker
//
//  Created by Vladislav on 27.07.2024.
//

import SwiftUI

struct PriceChangeTriangle: View {
    var ticker: Ticker
    
    var body: some View {
        HStack {
            Image(systemName: ticker.priceChangePercentage24H < 0 ? "triangle.fill" : "triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 8, height: 8)                            .foregroundStyle(ticker.priceChangePercentage24H < 0 ? .red : .green)
                .rotationEffect(ticker.priceChangePercentage24H < 0 ? .degrees(180) : .degrees(0))
        }
    }
}

struct Triangle: View {
    var body: some View {
        HStack {
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 8, height: 8)
                .foregroundStyle(.blue)
        }
    }
}

