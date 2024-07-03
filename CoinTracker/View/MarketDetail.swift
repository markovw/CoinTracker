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
                Text("\(ticker.name.capitalized)").font(.title).fontWeight(.bold)
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 40, height: 25)
                    .foregroundStyle(.black.opacity(0.75))
                    .overlay {
                        Text("#\(ticker.marketCapRank)")
                            .foregroundStyle(.gray.opacity(1))
                    }
                Spacer()
                
                AsyncImage(url: URL(string: ticker.image)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .frame(width: 45, height: 45)
                    }
                }
            }
            .padding()
            
            HStack {
                RoundedRectangle(cornerRadius: 10)
                    .overlay {
                        VStack {
                            Text("Current Price")
                            
                            Text(ticker.currentPrice.toCurrency() + " $")
                                .font(.title2.bold())
                            RoundedRectangle(cornerRadius: 8)
                                .frame(width: 90, height: 35)
                                .foregroundStyle(ticker.priceChangePercentage24H < 0 ? .red : .green)
                                .overlay {
                                    Text(ticker.priceChangePercentage24H.toPercentString())
                                        .foregroundStyle(.white)
                                }
                        }
                        .foregroundStyle(Color("backgroundColor"))
                    }
                RoundedRectangle(cornerRadius: 10)
                    .overlay {
                        VStack(alignment: .center) {
                            Text("Market Cap")
                            Text("\(String(format: "%.2f", ticker.marketCap / 1000000000)) $ B").font(.title2.bold()).lineLimit(1)
                            RoundedRectangle(cornerRadius: 8)
                                .frame(width: 90, height: 35)
                                .foregroundStyle (ticker.marketCapChangePercentage24H < 0 ? .red : .green)
                                .overlay {
                                    Text(ticker.marketCapChangePercentage24H.toPercentString())
                                        .foregroundStyle(.white)
                                }
                        }
                        .foregroundStyle(Color("backgroundColor"))
                    }
            }
            .frame(width: UIScreen.main.bounds.width - 20, height: 150)
            .opacity(0.85)
            .padding()
        }
        
//        Rectangle() // graph view
//            .frame(width: UIScreen.main.bounds.width - 20, height: 300)
//            .opacity(0.1)
//            .overlay {
//                Text("Graph View")
//            }
        MarketChart(ticker: ticker)
        
        Spacer()
        
            .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    MarketDetail(ticker: Ticker(id: "ethereum", symbol: "BTC", name: "Bitcoin", image: "https://coin-images.coingecko.com/coins/images/44/large/xrp-symbol-white-128.png?1696501442", currentPrice: 10000, marketCap: 1000000000000, marketCapRank: 1, marketCapChangePercentage24H: 0.5, priceChangePercentage24H: 7.2))
}
