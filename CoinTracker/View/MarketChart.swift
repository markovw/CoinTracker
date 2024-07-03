import SwiftUI
import Combine
import Charts

struct MarketChart: View {
    @StateObject private var viewModel: MarketChartViewModel
    let ticker: Ticker
    
    init(ticker: Ticker) {
        self.ticker = ticker
        _viewModel = StateObject(wrappedValue: MarketChartViewModel(ticker: ticker))
    }
    
    var body: some View {
        VStack {
            Picker("Select Period", selection: $viewModel.selectedPeriod) {
                ForEach(MarketChartViewModel.Period.allCases, id: \.self) { period in
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
            viewModel.fetchPrices()
        }
        .navigationTitle(ticker.id.capitalized)
    }
}

struct LineChartView: View {
    let prices: [Double]
    
    var body: some View {
        Chart {
            ForEach(prices.indices, id: \.self) { index in
                LineMark(
                    x: .value("Time", index),
                    y: .value("Price", prices[index])
                )
                .lineStyle(StrokeStyle(lineWidth: 2))
                .foregroundStyle(Color(.green))
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading)
        }
    }
}
