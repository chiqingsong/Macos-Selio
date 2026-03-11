import SwiftData
import SwiftUI

struct SettingsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \TemplateItem.sortOrder) private var templates: [TemplateItem]

    @State private var newReviewTitle = ""
    @State private var newTodoTitle = ""

    private var reviewTemplates: [TemplateItem] {
        templates.filter { $0.section == .review }
    }

    private var todoTemplates: [TemplateItem] {
        templates.filter { $0.section == .todo }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Settings")
                    .font(.system(size: 34, weight: .regular, design: .monospaced))

                templateEditor(
                    title: "Review Template",
                    items: reviewTemplates,
                    newTitle: $newReviewTitle,
                    section: .review
                )

                templateEditor(
                    title: "Todo Template",
                    items: todoTemplates,
                    newTitle: $newTodoTitle,
                    section: .todo
                )
            }
            .padding(28)
        }
    }

    private func templateEditor(
        title: String,
        items: [TemplateItem],
        newTitle: Binding<String>,
        section: ChecklistSection
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.system(size: 18, weight: .regular, design: .monospaced))

            ForEach(items) { item in
                HStack {
                    Text(item.title)
                        .font(.system(size: 15, weight: .regular, design: .monospaced))
                    Spacer()
                    Button("Delete") {
                        modelContext.delete(item)
                        normalizeSortOrder(for: section)
                        try? modelContext.save()
                    }
                    .buttonStyle(.borderless)
                    .foregroundStyle(.secondary)
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color.white.opacity(0.68))
                )
            }

            HStack {
                TextField("Add placeholder", text: newTitle)
                    .textFieldStyle(.roundedBorder)
                Button("Add") {
                    addTemplate(title: newTitle.wrappedValue, section: section)
                    newTitle.wrappedValue = ""
                }
                .disabled(newTitle.wrappedValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
    }

    private func addTemplate(title: String, section: ChecklistSection) {
        let cleanedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard cleanedTitle.isEmpty == false else {
            return
        }

        let sortOrder = templates.filter { $0.section == section }.count
        modelContext.insert(TemplateItem(title: cleanedTitle, section: section, sortOrder: sortOrder))
        try? modelContext.save()
    }

    private func normalizeSortOrder(for section: ChecklistSection) {
        let scopedItems = templates
            .filter { $0.section == section }
            .sorted { $0.sortOrder < $1.sortOrder }

        for (index, item) in scopedItems.enumerated() {
            item.sortOrder = index
        }
    }
}
