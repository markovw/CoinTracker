//
//  NetworkManager.swift
//  CoinTracker
//
//  Created by Vladislav on 09.06.2024.
//

import SwiftUI
import Foundation

final class NetworkManager {
    func loadData() async throws -> [Ticker] {
        let coinsArray = ["bitcoin", "ethereum", "the-open-network", "ripple", "aptos", "arbitrum", "notcoin"]
        let coinsString = coinsArray.joined(separator: ",")
        
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "vs_currency", value: "usd"),
            URLQueryItem(name: "ids", value: coinsString),
            URLQueryItem(name: "price_change_percentage", value: "1h"),
        ]
        components.queryItems = queryItems
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "x-cg-demo-api-key": "\(APIKeys().key)"
        ]
        
        print("Request URL: \(request.url!)")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        print(String(decoding: data, as: UTF8.self))
        
        do { // convert to camel case
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let tickers = try decoder.decode([Ticker].self, from: data)
            
            if tickers.isEmpty {
                throw CRError.invalidData
            }
            
            return tickers
        } catch {
            throw CRError.invalidData
        }
    }
}
