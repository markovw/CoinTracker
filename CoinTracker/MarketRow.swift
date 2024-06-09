//
//  MarketRow.swift
//  CoinTracker
//
//  Created by Vladislav on 05.06.2024.
//

import SwiftUI

struct MarketRow: View {
    var body: some View {
        List {
            HStack {
                Text("#")
                Text("Market cap")
                    .padding(.trailing, 125)
                Text("Price")
                    .padding(.trailing, 50)
                Text("24h %")
            }
            .font(.caption)
            
            
            HStack {
                Text("1")
                Image("bitcoinlogo")
                    .resizable()
                    .frame(width: 40, height: 25)
                VStack(alignment: .leading) {
                    Text("BTC")
                        .fontWeight(.medium)
                        .font(.caption)
                        .padding(.bottom, 3)
                    
                    Text("$1,39 T")
                        .font(.caption)
                }
                .padding(.leading, -5)
                .padding(.trailing, 50)
                
                
                Text("70.817,40 $")
                    .fontWeight(.medium)
                    .font(.subheadline)
            }
            .padding(.bottom, 5)
        }.listStyle(.plain)
    }
}

#Preview {
    MarketRow()
}
