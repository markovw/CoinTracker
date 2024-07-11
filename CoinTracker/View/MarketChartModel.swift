import SwiftUI
import Combine

class MarketChartModel: ObservableObject {
    @Published var prices: [(timestamp: TimeInterval, price: Double)] = []
    @Published var selectedPeriod: Period = .day
    
    private var allPrices: [(timestamp: TimeInterval, price: Double)] = []
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
        
        var duration: TimeInterval {
            switch self {
            case .day: return 86400
            case .week: return 604800
            case .month: return 2629743
            case .year: return 31556926
            case .all: return .greatestFiniteMagnitude
            }
        }
    }
    
    init(ticker: Ticker) {
        self.ticker = ticker
        fetchAllPrices()
    }
    
    private func fetchAllPrices() {
        let now = Date().timeIntervalSince1970
        let oneYearAgo = now - 365 * 24 * 60 * 60 // Since beginning of time to now
        
        api.fetchPrices(for: ticker.id, from: oneYearAgo, to: now)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("Successfully fetched all prices")
                    case .failure(let error):
                        print("Failed to fetch prices: \(error)")
                    }
                },
                receiveValue: { [weak self] prices in
                    self?.allPrices = prices.map { price in
                        (timestamp: price[0], price: price[1])
                    }
                    self?.updatePrices(for: .day)
                }
            )
            .store(in: &cancellables)
    }
    
    private func updatePrices(for period: Period) {
        print("updatePrices started for period: \(period)")
        let now = Date().timeIntervalSince1970
        let startTime = now - period.duration
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            
            let filteredPrices = self.allPrices.filter { $0.timestamp >= startTime }
            
            // Limit the number of points to 1000
            let stride = max(1, filteredPrices.count / 1000)
            let limitedPrices = stride > 1 ? filteredPrices.enumerated().compactMap { $0.offset % stride == 0 ? $0.element : nil } : filteredPrices
            
            DispatchQueue.main.async {
                self.prices = Array(limitedPrices)
                print("Updated prices for period \(period.title): \(self.prices.count) data points")
            }
        }
    }
    
    func selectPeriod(_ period: Period) {
        selectedPeriod = period
        updatePrices(for: period)
    }
}
