import SwiftUI

struct TemplateEditorSectionView: View {
    let title: String
    let items: [TemplateItem]
    @Binding var draftTitle: String
    let onAdd: () -> Void
    let onDelete: (TemplateItem) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.system(.title3, design: .monospaced))
                .foregroundStyle(AppTheme.Palette.ink)

            ForEach(items) { item in
                HStack {
                    Text(item.title)
                        .font(.system(.body, design: .monospaced))
                        .foregroundStyle(AppTheme.Palette.ink)
                    Spacer()
                    Button("Delete", action: { onDelete(item) })
                        .buttonStyle(.borderless)
                        .foregroundStyle(AppTheme.Palette.secondaryInk)
                }
                .padding(14)
                .background(AppTheme.Palette.rowFill)
                .clipShape(RoundedRectangle(cornerRadius: AppTheme.Layout.rowCorner))
            }

            HStack {
                TextField("Add placeholder", text: $draftTitle)
                    .textFieldStyle(.roundedBorder)
                Button("Add", action: onAdd)
                    .disabled(draftTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
    }
}
