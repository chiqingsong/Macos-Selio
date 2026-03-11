import CoreGraphics
import Foundation

struct WeeklyProgressRow: Identifiable {
    let id = UUID()
    let title: String
    let done: Int

    var progress: CGFloat {
        CGFloat(done) / 7
    }
}
