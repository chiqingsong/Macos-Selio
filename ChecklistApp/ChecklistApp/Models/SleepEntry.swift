import Foundation
import SwiftData

@Model
final class SleepEntry {
    var date: Date
    var sleptBeforeMidnight: Bool

    init(date: Date, sleptBeforeMidnight: Bool) {
        self.date = date
        self.sleptBeforeMidnight = sleptBeforeMidnight
    }
}
