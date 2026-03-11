import SwiftUI

struct ChecklistSectionView: View {
    let title: String
    let items: [DayItem]
    let onToggle: (DayItem) -> Void
    let onRemove: (DayItem) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(title)
                .font(.system(size: 18, weight: .regular, design: .monospaced))
                .foregroundStyle(.black.opacity(0.8))

            if items.isEmpty {
                Text("No items yet")
                    .font(.system(size: 14, design: .monospaced))
                    .foregroundStyle(.secondary)
                    .padding(.vertical, 8)
            } else {
                ForEach(items) { item in
                    HStack(spacing: 14) {
                        Button(action: {
                            onToggle(item)
                        }) {
                            Image(systemName: item.status == .done ? "checkmark.square" : "square")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundStyle(item.status == .done ? Color.orange : Color.secondary)
                        }
                        .buttonStyle(.plain)

                        Text(item.title)
                            .font(.system(size: 16, weight: .regular, design: .monospaced))
                            .foregroundStyle(item.status == .done ? Color.orange : Color.primary)

                        Spacer()

                        Text(item.status == .done ? "Done" : "Pending")
                            .font(.system(size: 13, weight: .regular, design: .monospaced))
                            .foregroundStyle(item.status == .done ? Color.orange : Color.secondary)

                        Button("Skip") {
                            onRemove(item)
                        }
                        .buttonStyle(.borderless)
                        .foregroundStyle(.secondary)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                    .background(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(item.status == .done ? Color.orange.opacity(0.08) : Color.white.opacity(0.65))
                    )
                }
            }
        }
    }
}
