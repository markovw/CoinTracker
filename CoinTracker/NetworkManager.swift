//
//  NetworkManager.swift
//  CoinTracker
//
//  Created by Vladislav on 09.06.2024.
//

import SwiftUI

final class NetworkManager {
    func getUser() async throws -> Ticker {
        let endpoint = "https://api.coingecko.com/api/v3/ping/?x_cg_demo_api_key/=\(APIKeys().key)"
        
        guard let url = URL(string: endpoint) else {
            throw CRError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CRError.invalidResponse
        } // catch error with response
         
        do { // convert to camel case
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            return try decoder.decode(Ticker.self, from: data)
        } catch {
            throw CRError.invalidData
        }
    }
}

