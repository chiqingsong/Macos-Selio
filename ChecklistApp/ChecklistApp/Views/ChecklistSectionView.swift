import SwiftUI

struct ChecklistSectionView: View {
    let items: [DayItem]
    let onToggle: (DayItem) -> Void
    let onRemove: (DayItem) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            ForEach(items) { item in
                HStack(spacing: 16) {
                    Button("Toggle \(item.title)", systemImage: item.status == .done ? "checkmark.square" : "square", action: {
                        onToggle(item)
                    })
                    .buttonStyle(.plain)
                    .labelStyle(.iconOnly)
                    .foregroundStyle(item.status == .done ? AppTheme.Palette.accent : AppTheme.Palette.secondaryInk)
                    .frame(width: 28, height: 28)

                    Text(item.title)
                        .font(.system(size: 21, design: .monospaced))
                        .foregroundStyle(item.status == .done ? AppTheme.Palette.accent : AppTheme.Palette.ink)

                    Spacer()

                    Text(item.status == .done ? "Done" : "—")
                        .font(.system(.title3, design: .monospaced))
                        .foregroundStyle(item.status == .done ? AppTheme.Palette.accent : AppTheme.Palette.secondaryInk)

                    Button("Skip", action: { onRemove(item) })
                        .buttonStyle(.borderless)
                        .foregroundStyle(AppTheme.Palette.secondaryInk)
                }
                .padding(.horizontal, 18)
                .padding(.vertical, 18)
                .background(item.status == .done ? AppTheme.Palette.accentMuted : AppTheme.Palette.rowFill)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.Layout.rowCorner))
    }
}
