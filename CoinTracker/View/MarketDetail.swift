//
//  MarketDetail.swift
//  CoinTracker
//
//  Created by Vladislav on 05.06.2024.
//

import SwiftUI

struct MarketDetail: View {
    let ticker: Ticker
    
    var body: some View {
        VStack(alignment: .leading, spacing: -10) {
            HStack {
                Text("\(ticker.id.capitalized)")
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 40, height: 25)
                    .foregroundStyle(.black.opacity(0.75))
                    .overlay {
                        Text("#\(ticker.marketCapRank)")
                            .foregroundStyle(.gray.opacity(1))
                    }
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                Text("\(String(format: "%.2f", ticker.currentPrice)) $").font(.title2.bold())
                
                Spacer()
                
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 150, height: 35)
                    .foregroundStyle(.green.gradient)
                    .overlay {
                        Text("\(String(format: "%.2f", ticker.priceChangePercentage24H)) %")
                    }
            }
            .padding()
            
            HStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 310, height: 35)
                    .padding(.leading)
                    .opacity(0.2)
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 45, height: 35)
            }.padding(.top)
            
        }
        
        Rectangle()
            .frame(height: 300)
            .opacity(0.1)
            .padding()
            .overlay {
                Text("Graph View")
            }
        
        Spacer()
        
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    MarketDetail(ticker: Ticker(id: "ethereum", symbol: "BTC", name: "Bitcoin", image: "https://example.com/image1.png", currentPrice: 10000, marketCap: 1000000000000, marketCapRank: 1, priceChangePercentage24H: 7.2))
}
