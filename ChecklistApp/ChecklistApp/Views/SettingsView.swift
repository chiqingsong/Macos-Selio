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
                    .font(.system(size: 34, design: .monospaced))
                    .foregroundStyle(AppTheme.Palette.ink)

                Text("Keep the app lean. Templates live here, the ritual stays on the main tabs.")
                    .font(.system(.body, design: .monospaced))
                    .foregroundStyle(AppTheme.Palette.secondaryInk)

                TemplateEditorSectionView(
                    title: "Review Template",
                    items: reviewTemplates,
                    draftTitle: $newReviewTitle,
                    onAdd: addReviewTemplate,
                    onDelete: deleteReviewTemplate
                )

                TemplateEditorSectionView(
                    title: "Todo Template",
                    items: todoTemplates,
                    draftTitle: $newTodoTitle,
                    onAdd: addTodoTemplate,
                    onDelete: deleteTodoTemplate
                )
            }
            .padding(AppTheme.Layout.innerPadding)
        }
    }

    private func addReviewTemplate() {
        addTemplate(title: newReviewTitle, section: .review)
        newReviewTitle = ""
    }

    private func addTodoTemplate() {
        addTemplate(title: newTodoTitle, section: .todo)
        newTodoTitle = ""
    }

    private func deleteReviewTemplate(_ item: TemplateItem) {
        deleteTemplate(item, section: .review)
    }

    private func deleteTodoTemplate(_ item: TemplateItem) {
        deleteTemplate(item, section: .todo)
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

    private func deleteTemplate(_ item: TemplateItem, section: ChecklistSection) {
        modelContext.delete(item)
        normalizeSortOrder(for: section)
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
