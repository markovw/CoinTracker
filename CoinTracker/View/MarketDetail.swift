//
//  MarketDetail.swift
//  CoinTracker
//
//  Created by Vladislav on 05.06.2024.
//

import SwiftUI
import Kingfisher

struct MarketDetail: View {
    @StateObject private var alertManager = AlertManager()
    @EnvironmentObject private var favorites: Favorites
    let ticker: Ticker
    
    var body: some View {
        ZStack {
            ScrollView {
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
                        
                        Button {
                            if favorites.contains(ticker) {
                                favorites.remove(ticker)
                            } else {
                                favorites.add(ticker)
                                alertManager.show(message: "\(ticker.name) is now on your Watchlist!")
                            }
                        } label: {
                            Image(systemName: favorites.contains(ticker) ? "star.fill" : "star.fill")
                        }
                        .foregroundStyle(favorites.contains(ticker) ? Color(.yellow) : Color(.gray))
                        
                        Spacer()

                        KFImage(URL(string: ticker.image))
                            .resizable()
                            .frame(width: 45, height: 45)
                    }
                    .padding()
                    
                    HStack {
                        InfoCard(title: "Current Price", value: ticker.currentPrice.toCurrency() + " $", changePercentage: ticker.priceChangePercentage24H)
                        
                        InfoCard(title: "Market Cap", value: ("\(String(format: "%.2f", ticker.marketCap / 1000000000)) $ B"), changePercentage: ticker.marketCapChangePercentage24H)
                    }
                    .frame(width: UIScreen.main.bounds.width - 20, height: 150)
                    .padding()
                    
                    MarketChart(ticker: ticker)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Statistics").font(.headline.bold()).padding(.vertical, 10)
                        
                        Group {
                            Text("All time High:").padding(.bottom, -5).opacity(0.8)
                            Text(ticker.ath.toCurrency() + "$").fontWeight(.bold)
                        }.font(.caption)
                        
                        Group {
                            Text("All time Low:").padding(.bottom, -5).opacity(0.8)
                            Text(ticker.atl.toCurrency() + "$").fontWeight(.bold)
                        }.font(.caption)
                    }
                    .padding()
                    
                    Spacer()
                        .toolbar(.hidden, for: .tabBar)
                    
                    
                }
                .environmentObject(favorites)
            }
            .background(Color("backgroundColor"))
            
            AlertView(alertManager: alertManager, ticker: ticker)
        }
    }
}

#Preview {
    MarketDetail(ticker: Ticker(id: "ethereum", symbol: "BTC", name: "Bitcoin", image: "https://coin-images.coingecko.com/coins/images/44/large/xrp-symbol-white-128.png?1696501442", currentPrice: 10000, marketCap: 1000000000000, marketCapRank: 1, marketCapChangePercentage24H: 0.5, priceChangePercentage24H: 7.2, atl: 1.0, atlChangePercentage: 2.0, ath: 2.0, athChangePercentage: 2.1))
        .environmentObject(Favorites())
}
