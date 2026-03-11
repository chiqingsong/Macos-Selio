import Foundation
import SwiftData

enum DailyGenerator {
    static func generateIfNeeded(for date: Date, context: ModelContext) {
        let day = Calendar.current.startOfDay(for: date)
        guard countDayItems(context, on: day) == 0 else {
            return
        }

        let descriptor = FetchDescriptor<TemplateItem>(
            sortBy: [SortDescriptor(\TemplateItem.sortOrder)]
        )
        let templates = (try? context.fetch(descriptor)) ?? []

        for template in templates {
            let item = DayItem(
                title: template.title,
                section: template.section,
                status: .notDone,
                date: day,
                templateId: template.id
            )
            context.insert(item)
        }

        try? context.save()
    }

    static func countDayItems(_ context: ModelContext) -> Int {
        let descriptor = FetchDescriptor<DayItem>()
        return (try? context.fetchCount(descriptor)) ?? 0
    }

    static func countDayItems(_ context: ModelContext, on date: Date) -> Int {
        let descriptor = FetchDescriptor<DayItem>(
            predicate: #Predicate<DayItem> { item in
                item.date == date
            }
        )
        return (try? context.fetchCount(descriptor)) ?? 0
    }
}
