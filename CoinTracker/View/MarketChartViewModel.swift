//
//  CryptoViewModel.swift
//  CoinTracker
//
//  Created by Vladislav on 03.07.2024.
//

import SwiftUI
import Combine

class MarketChartViewModel: ObservableObject {
    @Published var prices: [Double] = []
    @Published var selectedPeriod: Period = .day
    
    private var cancellables: Set<AnyCancellable> = []
    private let api = ChartAPI()
    private let ticker: Ticker
    
    enum Period: CaseIterable {
        case day
        case week
        case month
        case year
        case all
        
        var title: String {
            switch self {
            case .day: return "1D"
            case .week: return "1W"
            case .month: return "1M"
            case .year: return "1Y"
            case .all: return "All"
            }
        }
        
        var dateRange: (TimeInterval, TimeInterval) {
            let now = Date().timeIntervalSince1970
            switch self {
            case .day:
                return (now - 86400, now)
            case .week:
                return (now - 604800, now)
            case .month:
                return (now - 2629743, now)
            case .year:
                return (now - 31556926, now)
            case .all:
                return (0, now)
            }
        }
    }
    
    init(ticker: Ticker) {
        self.ticker = ticker
        fetchPrices()
    }
    
    func fetchPrices() {
        let (from, to) = selectedPeriod.dateRange
        api.fetchPrices(for: ticker.id, from: from, to: to)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] prices in
                self?.prices = prices
            })
            .store(in: &cancellables)
    }
    
    func selectPeriod(_ period: Period) {
        selectedPeriod = period
        fetchPrices()
    }
}
