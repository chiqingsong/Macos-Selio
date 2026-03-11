import Foundation
import SwiftData

@Model
final class DayItem {
    var id: UUID
    var date: Date
    private var sectionRawValue: String
    var title: String
    private var statusRawValue: String
    var templateId: UUID?

    var section: ChecklistSection {
        get { ChecklistSection(rawValue: sectionRawValue) ?? .review }
        set { sectionRawValue = newValue.rawValue }
    }

    var status: DayItemStatus {
        get { DayItemStatus(rawValue: statusRawValue) ?? .notDone }
        set { statusRawValue = newValue.rawValue }
    }

    init(
        id: UUID = UUID(),
        title: String,
        section: ChecklistSection,
        status: DayItemStatus = .notDone,
        date: Date,
        templateId: UUID? = nil
    ) {
        self.id = id
        self.title = title
        self.sectionRawValue = section.rawValue
        self.statusRawValue = status.rawValue
        self.date = date
        self.templateId = templateId
    }
}
