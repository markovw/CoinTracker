//
//  Ticker.swift
//  CoinTracker
//
//  Created by Vladislav on 05.06.2024.
//

import SwiftUI

struct Ticker: Hashable, Codable {
    var id: Int
    var icon: String
    var coinName: String
    var capitalization: Int
    var price: Int
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
}

