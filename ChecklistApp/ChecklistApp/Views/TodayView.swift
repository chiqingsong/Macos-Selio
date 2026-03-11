import SwiftData
import SwiftUI

struct TodayView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \DayItem.title) private var allDayItems: [DayItem]

    private var today: Date {
        Calendar.current.startOfDay(for: Date())
    }

    private var todayItems: [DayItem] {
        allDayItems
            .filter { Calendar.current.isDate($0.date, inSameDayAs: today) }
            .sorted { lhs, rhs in
                if lhs.section == rhs.section {
                    return lhs.title < rhs.title
                }
                return lhs.section.rawValue < rhs.section.rawValue
            }
    }

    private var reviewItems: [DayItem] {
        todayItems.filter { $0.section == .review && $0.status != .removed }
    }

    private var todoItems: [DayItem] {
        todayItems.filter { $0.section == .todo && $0.status != .removed }
    }

    private var counts: CompletionCounts {
        CompletionCounter.count(todayItems)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                HStack(alignment: .firstTextBaseline) {
                    Text("Today")
                        .font(.system(size: 34, weight: .regular, design: .monospaced))
                    Spacer()
                    Text("\(counts.done)/\(counts.total) done")
                        .font(.system(size: 18, weight: .regular, design: .monospaced))
                        .foregroundStyle(.secondary)
                }

                ChecklistSectionView(
                    title: "Review",
                    items: reviewItems,
                    onToggle: toggle,
                    onRemove: markRemoved
                )

                ChecklistSectionView(
                    title: "Todo",
                    items: todoItems,
                    onToggle: toggle,
                    onRemove: markRemoved
                )
            }
            .padding(28)
        }
        .onAppear {
            DailyGenerator.generateIfNeeded(for: today, context: modelContext)
        }
    }

    private func toggle(_ item: DayItem) {
        item.status = item.status == .done ? .notDone : .done
        try? modelContext.save()
    }

    private func markRemoved(_ item: DayItem) {
        item.status = .removed
        try? modelContext.save()
    }
}
