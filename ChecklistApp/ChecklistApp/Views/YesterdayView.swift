import SwiftData
import SwiftUI

struct YesterdayView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \SleepEntry.date) private var sleepEntries: [SleepEntry]

    private var yesterday: Date {
        Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date())
    }

    private var existingEntry: SleepEntry? {
        sleepEntries.first { Calendar.current.isDate($0.date, inSameDayAs: yesterday) }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Yesterday")
                .font(.system(size: 34, weight: .regular, design: .monospaced))

            Toggle(isOn: Binding(
                get: { existingEntry?.sleptBeforeMidnight ?? false },
                set: { newValue in
                    updateSleepEntry(newValue)
                }
            )) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Slept before midnight")
                        .font(.system(size: 18, weight: .regular, design: .monospaced))
                    Text("A simple recap for last night's sleep.")
                        .font(.system(size: 13, weight: .regular, design: .monospaced))
                        .foregroundStyle(.secondary)
                }
            }
            .toggleStyle(.switch)
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(Color.white.opacity(0.72))
            )

            Spacer()
        }
        .padding(28)
    }

    private func updateSleepEntry(_ value: Bool) {
        if let existingEntry {
            existingEntry.sleptBeforeMidnight = value
        } else {
            modelContext.insert(SleepEntry(date: yesterday, sleptBeforeMidnight: value))
        }
        try? modelContext.save()
    }
}
