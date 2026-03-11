import SwiftUI

struct WeeklyProgressView: View {
    let items: [DayItem]

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                Text("This Week")
                    .font(.system(.title3, design: .monospaced))
                    .foregroundStyle(AppTheme.Palette.secondaryInk)
                Spacer()
                Text(summaryText)
                    .font(.system(.title3, design: .monospaced))
                    .foregroundStyle(AppTheme.Palette.ink)
            }

            ForEach(progressRows) { row in
                VStack(alignment: .leading, spacing: 8) {
                    Text(row.title)
                        .font(.system(.title3, design: .monospaced))
                        .foregroundStyle(AppTheme.Palette.ink)

                    HStack(spacing: 14) {
                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                Capsule()
                                    .fill(Color.white)
                                Capsule()
                                    .fill(AppTheme.Palette.accentMuted)
                                    .frame(width: geometry.size.width * row.progress)
                                Capsule()
                                    .stroke(AppTheme.Palette.divider, lineWidth: 1)
                            }
                        }
                        .frame(height: 12)

                        Text("\(row.done)/7")
                            .font(.system(.body, design: .monospaced))
                            .foregroundStyle(AppTheme.Palette.accent)
                    }
                }
            }
        }
        .padding(24)
        .background(AppTheme.Palette.panelFill)
        .overlay(alignment: .top) {
            Rectangle()
                .fill(AppTheme.Palette.divider)
                .frame(height: 1)
                .padding(.top, 0)
        }
    }

    private var progressRows: [WeeklyProgressRow] {
        let grouped = Dictionary(grouping: items.filter { $0.status != .removed }, by: \.title)
        return grouped.keys.sorted().map { key in
            let values = grouped[key] ?? []
            let done = values.filter { $0.status == .done }.count
            return WeeklyProgressRow(title: key, done: done)
        }
    }

    private var summaryText: String {
        let done = items.filter { $0.status == .done }.count
        return "\(done)/\(max(items.count, 1))"
    }
}
