import Foundation
import SwiftUI

class Favorites: ObservableObject {
    @AppStorage("Favorites") private var storedTickers: String = ""
    @Published private var tickers: Set<String> = []

    init() {
        load()
    }

    func contains(_ ticker: Ticker) -> Bool {
        tickers.contains(ticker.id)
    }

    func add(_ ticker: Ticker) {
        tickers.insert(ticker.id)
        save()
    }

    func remove(_ ticker: Ticker) {
        tickers.remove(ticker.id)
        save()
    }

    private func save() {
        storedTickers = tickers.joined(separator: ",")
    }

    private func load() {
        tickers = Set(storedTickers.components(separatedBy: ",").filter { !$0.isEmpty })
        print(storedTickers)
    }
}
