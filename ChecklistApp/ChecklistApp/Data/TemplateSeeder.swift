import Foundation
import SwiftData

enum TemplateSeeder {
    private static let reviewPlaceholders = [
        "Morning note",
        "Energy check",
        "One key reflection",
    ]

    private static let todoPlaceholders = [
        "Deep work block",
        "Inbox cleanup",
        "Evening reset",
    ]

    static func seedIfNeeded(_ context: ModelContext) {
        let descriptor = FetchDescriptor<TemplateItem>()
        let existingCount = (try? context.fetchCount(descriptor)) ?? 0

        guard existingCount == 0 else {
            return
        }

        for (index, title) in reviewPlaceholders.enumerated() {
            context.insert(TemplateItem(title: title, section: .review, sortOrder: index))
        }

        for (index, title) in todoPlaceholders.enumerated() {
            context.insert(TemplateItem(title: title, section: .todo, sortOrder: index))
        }

        try? context.save()
    }

    static func countTemplates(_ context: ModelContext) -> Int {
        let descriptor = FetchDescriptor<TemplateItem>()
        return (try? context.fetchCount(descriptor)) ?? 0
    }
}
