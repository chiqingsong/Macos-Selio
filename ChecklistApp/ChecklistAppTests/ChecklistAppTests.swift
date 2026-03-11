import SwiftData
import XCTest
@testable import ChecklistApp

final class ChecklistAppTests: XCTestCase {
    func testAppModuleLoads() {
        XCTAssertTrue(true)
    }

    func testTemplateItemInit() {
        let item = TemplateItem(title: "Meditation", section: .review, sortOrder: 0)
        XCTAssertEqual(item.title, "Meditation")
        XCTAssertEqual(item.section, .review)
    }

    func testTemplateSeedingCreatesDefaults() throws {
        let context = try InMemoryModelContextFactory.make()
        TemplateSeeder.seedIfNeeded(context)
        let count = TemplateSeeder.countTemplates(context)
        XCTAssertGreaterThan(count, 0)
    }

    func testDailyGenerationCreatesItemsFromTemplates() throws {
        let context = try InMemoryModelContextFactory.make()
        TemplateSeeder.seedIfNeeded(context)

        DailyGenerator.generateIfNeeded(for: Date(), context: context)

        let count = DailyGenerator.countDayItems(context)
        XCTAssertGreaterThan(count, 0)
    }

    func testCompletionCountsExcludeRemoved() {
        let items = [
            DayItem(title: "A", section: .review, status: .done, date: Date()),
            DayItem(title: "B", section: .review, status: .removed, date: Date()),
        ]

        let counts = CompletionCounter.count(items)

        XCTAssertEqual(counts.done, 1)
        XCTAssertEqual(counts.total, 1)
    }

    func testSleepEntryDefaultIsFalse() {
        let entry = SleepEntry(date: Date(), sleptBeforeMidnight: false)
        XCTAssertFalse(entry.sleptBeforeMidnight)
    }

    func testTemplateItemSortOrder() {
        let item = TemplateItem(title: "X", section: .todo, sortOrder: 2)
        XCTAssertEqual(item.sortOrder, 2)
    }
}

enum InMemoryModelContextFactory {
    static func make() throws -> ModelContext {
        let schema = Schema([
            TemplateItem.self,
            DayItem.self,
            SleepEntry.self,
        ])
        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: schema, configurations: [configuration])
        return ModelContext(container)
    }
}
