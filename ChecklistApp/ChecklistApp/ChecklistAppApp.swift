import SwiftData
import SwiftUI

@main
struct ChecklistAppApp: App {
    private let sharedModelContainer: ModelContainer

    init() {
        let schema = Schema([
            TemplateItem.self,
            DayItem.self,
            SleepEntry.self,
        ])

        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            sharedModelContainer = try ModelContainer(for: schema, configurations: [configuration])
            TemplateSeeder.seedIfNeeded(sharedModelContainer.mainContext)
        } catch {
            fatalError("Unable to create model container: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
