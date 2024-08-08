//
//  Cards.swift
//  CoinTracker
//
//  Created by Vladislav on 08.08.2024.
//

import SwiftUI

struct InfoCardView: View {
    let title: String
    let value: String
    let changePercentage: Double
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .overlay {
                VStack {
                    Text(title).font(.headline).bold().opacity(0.7)
                    
                    Text(value).font(.headline.bold())
                    
                    ChangeIndicatorView(changePercentage: changePercentage)
                }
                .foregroundStyle(Color("backgroundColor"))
            }
            .background(Color.white).opacity(0.85)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct ChangeIndicatorView: View {
    let changePercentage: Double
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .frame(width: 90, height: 35)
            .foregroundStyle(changePercentage < 0 ? .red : .green)
            .overlay {
                Text(changePercentage.toPercentString())
                    .foregroundStyle(.white)
                    .font(.subheadline)
                    .bold()
            }
    }
}

