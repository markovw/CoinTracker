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
    
    func fetchPrices(for coin: String, from: TimeInterval, to: TimeInterval) -> AnyPublisher<[[Double]], Error> {
        var components = URLComponents(string: "\(ChartAPI.baseURL)/\(coin)/market_chart/range")!
        components.queryItems = [
            URLQueryItem(name: "vs_currency", value: "usd"),
            URLQueryItem(name: "from", value: String(Int(from))),
            URLQueryItem(name: "to", value: String(Int(to))),
        ]
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 30
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "x-cg-demo-api-key": APIKeys().key
        ]
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: MarketChartResponse.self, decoder: JSONDecoder())
            .map { $0.prices! }
            .eraseToAnyPublisher()
    }
    
    struct MarketChartResponse: Codable {
        let prices: [[Double]]?
        let error: APIError?
    }

    struct APIError: Codable {
        let status: ErrorStatus
    }

    struct ErrorStatus: Codable {
        let errorCode: Int
        let errorMessage: String
        
        enum CodingKeys: String, CodingKey {
            case errorCode = "error_code"
            case errorMessage = "error_message"
        }
    }
}
