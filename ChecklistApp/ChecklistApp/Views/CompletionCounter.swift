import Foundation

struct CompletionCounts {
    let done: Int
    let total: Int
}

enum CompletionCounter {
    static func count(_ items: [DayItem]) -> CompletionCounts {
        let visibleItems = items.filter { $0.status != .removed }
        let doneItems = visibleItems.filter { $0.status == .done }
        return CompletionCounts(done: doneItems.count, total: visibleItems.count)
    }
}
