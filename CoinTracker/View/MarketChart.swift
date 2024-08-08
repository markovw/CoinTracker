import SwiftUI
import Combine
import Charts

struct MarketChart: View {
    @StateObject private var viewModel: MarketChartModel
    let ticker: Ticker

    init(ticker: Ticker) {
        self.ticker = ticker
        _viewModel = StateObject(wrappedValue: MarketChartModel(ticker: ticker))
    }

    var body: some View {
        VStack {
            Picker("Select Period", selection: $viewModel.selectedPeriod) {
                ForEach(MarketChartModel.Period.allCases, id: \.self) { period in
                    Text(period.title).tag(period)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            LineChartView(prices: viewModel.prices)
                .frame(height: 300)

            Spacer()
        }
        .onChange(of: viewModel.selectedPeriod) { oldValue, newValue in
            viewModel.selectPeriod(newValue)
        }
        .navigationTitle(ticker.id.capitalized)
        .onAppear {
            viewModel.selectPeriod(viewModel.selectedPeriod)
        }
    }
}

struct LineChartView: View {
    let prices: [(timestamp: TimeInterval, price: Double)]
    
    var body: some View {
        Chart {
            ForEach(prices, id: \.timestamp) { price in
                LineMark(
                    x: .value("Time", Date(timeIntervalSince1970: price.timestamp)),
                    y: .value("Price", price.price))
            }
            .lineStyle(StrokeStyle(lineWidth: 2))
            .foregroundStyle(Color.green)
        }
    }
}
