//
//  NetworkManager.swift
//  CoinTracker
//
//  Created by Vladislav on 09.06.2024.
//

import SwiftUI
import Foundation
import Combine

final class NetworkManager {
    func loadData() async throws -> [Ticker] {
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
          URLQueryItem(name: "vs_currency", value: "usd"),
          URLQueryItem(name: "per_page", value: "100"),
          URLQueryItem(name: "sparkline", value: "true")]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "x-cg-demo-api-key": APIKeys().key
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

final class ChartAPI {
    static let baseURL = "https://api.coingecko.com/api/v3/coins"
    
    func fetchPrices(for coin: String, from: TimeInterval, to: TimeInterval) -> AnyPublisher<[Double], Error> {
        var components = URLComponents(string: "\(ChartAPI.baseURL)/\(coin)/market_chart/range")!
        components.queryItems = [
            URLQueryItem(name: "vs_currency", value: "usd"),
            URLQueryItem(name: "from", value: String(from)),
            URLQueryItem(name: "to", value: String(to)),
        ]
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
<<<<<<< Updated upstream
            "x-cg-demo-api-key": "CG-rAy6R4nQzYdy8TADwH6mjqUF"
=======
            "x-cg-demo-api-key": APIKeys().key
>>>>>>> Stashed changes
        ]
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: MarketChartResponse.self, decoder: JSONDecoder())
            .map { $0.prices.map { $0[1] } }
            .eraseToAnyPublisher()
    }
    
    struct MarketChartResponse: Codable {
        let prices: [[Double]]
    }
}
