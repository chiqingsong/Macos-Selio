import Foundation

struct FranklinVirtue: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let symbol: String
    let quote: String
    let completed: Bool
}
