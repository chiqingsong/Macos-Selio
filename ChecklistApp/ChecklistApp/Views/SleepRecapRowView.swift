import SwiftData
import SwiftUI

struct SleepRecapRowView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \SleepEntry.date) private var sleepEntries: [SleepEntry]

    private var yesterday: Date {
        Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date())
    }

    private var isDone: Bool {
        sleepEntries.first { Calendar.current.isDate($0.date, inSameDayAs: yesterday) }?.sleptBeforeMidnight ?? false
    }

    var body: some View {
        Button(action: toggleSleep) {
            HStack(spacing: 14) {
                Image(systemName: isDone ? "checkmark.square" : "square")
                    .font(.system(size: 20))
                    .foregroundStyle(isDone ? AppTheme.Palette.accent : AppTheme.Palette.secondaryInk)

                VStack(alignment: .leading, spacing: 4) {
                    Text("Yesterday Sleep")
                        .font(.system(.headline, design: .monospaced))
                        .foregroundStyle(AppTheme.Palette.secondaryInk)
                    Text("Slept before midnight")
                        .font(.system(.body, design: .monospaced))
                        .foregroundStyle(AppTheme.Palette.ink)
                }

                Spacer()

                Text(isDone ? "Yes" : "No")
                    .font(.system(.body, design: .monospaced))
                    .foregroundStyle(isDone ? AppTheme.Palette.accent : AppTheme.Palette.secondaryInk)
            }
            .padding(18)
            .background(AppTheme.Palette.rowFill)
            .clipShape(RoundedRectangle(cornerRadius: AppTheme.Layout.rowCorner))
        }
        .buttonStyle(.plain)
    }

    private func toggleSleep() {
        if let existingEntry = sleepEntries.first(where: { Calendar.current.isDate($0.date, inSameDayAs: yesterday) }) {
            existingEntry.sleptBeforeMidnight.toggle()
        } else {
            modelContext.insert(SleepEntry(date: yesterday, sleptBeforeMidnight: true))
        }
        try? modelContext.save()
    }
}
