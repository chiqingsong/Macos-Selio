import Foundation

enum ChecklistSection: String, Codable, CaseIterable {
    case review
    case todo
}

enum DayItemStatus: String, Codable, CaseIterable {
    case done
    case notDone
    case removed
}
