import Foundation
import SwiftData

@Model
final class TemplateItem {
    var id: UUID
    var title: String
    private var sectionRawValue: String
    var sortOrder: Int

    var section: ChecklistSection {
        get { ChecklistSection(rawValue: sectionRawValue) ?? .review }
        set { sectionRawValue = newValue.rawValue }
    }

    init(id: UUID = UUID(), title: String, section: ChecklistSection, sortOrder: Int) {
        self.id = id
        self.title = title
        self.sectionRawValue = section.rawValue
        self.sortOrder = sortOrder
    }
}
