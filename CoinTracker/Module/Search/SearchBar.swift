//
//  SearchBar.swift
//  CoinTracker
//
//  Created by Vladislav on 13.08.2024.
//

import SwiftUI

struct CustomSearchBar: View {
    @Binding var searchTerm: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.primary)
                .padding(.leading, 8)
            
            TextField("Search coins or addresses...", text: $searchTerm)
                .foregroundColor(.primary)
                .accentColor(.primary)
                .autocorrectionDisabled()
            
            Spacer()
            
            if !searchTerm.isEmpty {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 17, height: 17)
                    .padding(.horizontal)
                    .onTapGesture {
                        withAnimation(.easeOut(duration: 0.25)) {
                            searchTerm = ""
                        }
                    }
            }
        }
        .padding(.vertical, 15)
        .background(Color(UIColor.systemGray6))
        .cornerRadius(15)
        .padding(.horizontal)
    }
}
