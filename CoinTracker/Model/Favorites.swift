import Foundation
import SwiftUI

class Favorites: ObservableObject {
    @AppStorage("Favorites") private var storedTickers: String = ""
    @Published private var favoriteTickers: Set<String> = []
    
    init() {
        load()
    }
    
    func contains(_ ticker: Ticker) -> Bool {
        return favoriteTickers.contains(ticker.id)
    }
    
    func add(_ ticker: Ticker) {
        favoriteTickers.insert(ticker.id)
        save()
    }
    
    func remove(_ ticker: Ticker) {
        favoriteTickers.remove(ticker.id)
        save()
    }
    
    private func load() {
        favoriteTickers = Set(storedTickers.components(separatedBy: ",").filter { !$0.isEmpty })
        print(storedTickers)
    }
    
    private func save() {
        storedTickers = favoriteTickers.joined(separator: ",")
    }
}
