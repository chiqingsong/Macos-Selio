# macOS Checklist App Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Build a native macOS checklist app in SwiftUI with SwiftData persistence, matching the list-style prototype and supporting Today/Yesterday/Settings workflows.

**Architecture:** SwiftUI app with a tab-like top navigation for Today, Yesterday, Settings. SwiftData provides persistent storage for templates, daily items, and sleep entries. Daily data is generated from templates on first open per day.

**Tech Stack:** Swift 6, SwiftUI, SwiftData, XCTest.

---

### Task 1: Create project scaffold

**Files:**
- Create: `ChecklistApp/ChecklistApp.xcodeproj`
- Create: `ChecklistApp/ChecklistApp/ChecklistAppApp.swift`
- Create: `ChecklistApp/ChecklistApp/ContentView.swift`
- Create: `ChecklistApp/ChecklistApp/Assets.xcassets`
- Create: `ChecklistApp/ChecklistApp/Preview Content/Preview Assets.xcassets`
- Create: `ChecklistApp/ChecklistAppTests/ChecklistAppTests.swift`

**Step 1: Write the failing test**

```swift
import XCTest
@testable import ChecklistApp

final class ChecklistAppTests: XCTestCase {
    func testAppModuleLoads() {
        XCTAssertTrue(true)
    }
}
```

**Step 2: Run test to verify it fails**

Run: `xcodebuild -project ChecklistApp/ChecklistApp.xcodeproj -scheme ChecklistApp -destination 'platform=macOS' test`
Expected: FAIL (project/scheme not found)

**Step 3: Write minimal implementation**

Create a new SwiftUI macOS app named `ChecklistApp` with the files listed above.

**Step 4: Run test to verify it passes**

Run: `xcodebuild -project ChecklistApp/ChecklistApp.xcodeproj -scheme ChecklistApp -destination 'platform=macOS' test`
Expected: PASS

**Step 5: Commit**

```bash
git add ChecklistApp
 git commit -m "chore: scaffold ChecklistApp"
```

### Task 2: Add SwiftData models

**Files:**
- Create: `ChecklistApp/ChecklistApp/Models/TemplateItem.swift`
- Create: `ChecklistApp/ChecklistApp/Models/DayItem.swift`
- Create: `ChecklistApp/ChecklistApp/Models/SleepEntry.swift`
- Modify: `ChecklistApp/ChecklistApp/ChecklistAppApp.swift`
- Modify: `ChecklistApp/ChecklistAppTests/ChecklistAppTests.swift`

**Step 1: Write the failing test**

```swift
func testTemplateItemInit() {
    let item = TemplateItem(title: "Meditation", section: .review, sortOrder: 0)
    XCTAssertEqual(item.title, "Meditation")
    XCTAssertEqual(item.section, .review)
}
```

**Step 2: Run test to verify it fails**

Run: `xcodebuild -project ChecklistApp/ChecklistApp.xcodeproj -scheme ChecklistApp -destination 'platform=macOS' test`
Expected: FAIL (TemplateItem not found)

**Step 3: Write minimal implementation**

Implement SwiftData models:
- `TemplateItem` with `id`, `title`, `section`, `sortOrder`.
- `DayItem` with `id`, `date`, `section`, `title`, `status`, `templateId`.
- `SleepEntry` with `date`, `sleptBeforeMidnight`.

Add a `ModelContainer` to `ChecklistAppApp`.

**Step 4: Run test to verify it passes**

Run: `xcodebuild -project ChecklistApp/ChecklistApp.xcodeproj -scheme ChecklistApp -destination 'platform=macOS' test`
Expected: PASS

**Step 5: Commit**

```bash
git add ChecklistApp/ChecklistApp/Models ChecklistApp/ChecklistApp/ChecklistAppApp.swift ChecklistApp/ChecklistAppTests/ChecklistAppTests.swift
 git commit -m "feat: add SwiftData models"
```

### Task 3: Seed default templates

**Files:**
- Create: `ChecklistApp/ChecklistApp/Data/TemplateSeeder.swift`
- Modify: `ChecklistApp/ChecklistApp/ChecklistAppApp.swift`
- Modify: `ChecklistApp/ChecklistAppTests/ChecklistAppTests.swift`

**Step 1: Write the failing test**

```swift
func testTemplateSeedingCreatesDefaults() {
    let context = InMemoryModelContextFactory.make()
    TemplateSeeder.seedIfNeeded(context)
    let count = TemplateSeeder.countTemplates(context)
    XCTAssertGreaterThan(count, 0)
}
```

**Step 2: Run test to verify it fails**

Run: `xcodebuild -project ChecklistApp/ChecklistApp.xcodeproj -scheme ChecklistApp -destination 'platform=macOS' test`
Expected: FAIL (TemplateSeeder not found)

**Step 3: Write minimal implementation**

- `TemplateSeeder.seedIfNeeded(_:)` inserts placeholder items for review and todo.
- Provide helper `countTemplates(_:)` for tests.
- Add a small in-memory model context factory for tests.

**Step 4: Run test to verify it passes**

Run: `xcodebuild -project ChecklistApp/ChecklistApp.xcodeproj -scheme ChecklistApp -destination 'platform=macOS' test`
Expected: PASS

**Step 5: Commit**

```bash
git add ChecklistApp/ChecklistApp/Data ChecklistApp/ChecklistApp/ChecklistAppApp.swift ChecklistApp/ChecklistAppTests/ChecklistAppTests.swift
 git commit -m "feat: seed default templates"
```

### Task 4: Daily generation service

**Files:**
- Create: `ChecklistApp/ChecklistApp/Data/DailyGenerator.swift`
- Modify: `ChecklistApp/ChecklistAppTests/ChecklistAppTests.swift`

**Step 1: Write the failing test**

```swift
func testDailyGenerationCreatesItemsFromTemplates() {
    let context = InMemoryModelContextFactory.make()
    TemplateSeeder.seedIfNeeded(context)
    DailyGenerator.generateIfNeeded(for: Date(), context: context)
    let count = DailyGenerator.countDayItems(context)
    XCTAssertGreaterThan(count, 0)
}
```

**Step 2: Run test to verify it fails**

Run: `xcodebuild -project ChecklistApp/ChecklistApp.xcodeproj -scheme ChecklistApp -destination 'platform=macOS' test`
Expected: FAIL (DailyGenerator not found)

**Step 3: Write minimal implementation**

- `generateIfNeeded(for:context:)` checks for existing DayItems for the date.
- If missing, clones templates into DayItems with status `.notDone`.
- `countDayItems(_:)` for tests.

**Step 4: Run test to verify it passes**

Run: `xcodebuild -project ChecklistApp/ChecklistApp.xcodeproj -scheme ChecklistApp -destination 'platform=macOS' test`
Expected: PASS

**Step 5: Commit**

```bash
git add ChecklistApp/ChecklistApp/Data ChecklistApp/ChecklistAppTests/ChecklistAppTests.swift
 git commit -m "feat: generate daily items"
```

### Task 5: Today view (Review + Todo)

**Files:**
- Create: `ChecklistApp/ChecklistApp/Views/TodayView.swift`
- Create: `ChecklistApp/ChecklistApp/Views/ChecklistSectionView.swift`
- Modify: `ChecklistApp/ChecklistApp/ContentView.swift`
- Modify: `ChecklistApp/ChecklistAppTests/ChecklistAppTests.swift`

**Step 1: Write the failing test**

```swift
func testCompletionCountsExcludeRemoved() {
    let items = [
        DayItem(title: "A", section: .review, status: .done, date: Date()),
        DayItem(title: "B", section: .review, status: .removed, date: Date())
    ]
    let counts = CompletionCounter.count(items)
    XCTAssertEqual(counts.done, 1)
    XCTAssertEqual(counts.total, 1)
}
```

**Step 2: Run test to verify it fails**

Run: `xcodebuild -project ChecklistApp/ChecklistApp.xcodeproj -scheme ChecklistApp -destination 'platform=macOS' test`
Expected: FAIL (CompletionCounter not found)

**Step 3: Write minimal implementation**

- Build Today view with two sections (review/todo).
- Add completion header `done/total`.
- Add `CompletionCounter` helper.
- Hook list rows to toggle done/notDone and mark removed.

**Step 4: Run test to verify it passes**

Run: `xcodebuild -project ChecklistApp/ChecklistApp.xcodeproj -scheme ChecklistApp -destination 'platform=macOS' test`
Expected: PASS

**Step 5: Commit**

```bash
git add ChecklistApp/ChecklistApp/Views ChecklistApp/ChecklistApp/ContentView.swift ChecklistApp/ChecklistAppTests/ChecklistAppTests.swift
 git commit -m "feat: today view with completion counts"
```

### Task 6: Yesterday view (sleep recap)

**Files:**
- Create: `ChecklistApp/ChecklistApp/Views/YesterdayView.swift`
- Modify: `ChecklistApp/ChecklistApp/ContentView.swift`

**Step 1: Write the failing test**

```swift
func testSleepEntryDefaultIsFalse() {
    let entry = SleepEntry(date: Date(), sleptBeforeMidnight: false)
    XCTAssertFalse(entry.sleptBeforeMidnight)
}
```

**Step 2: Run test to verify it fails**

Run: `xcodebuild -project ChecklistApp/ChecklistApp.xcodeproj -scheme ChecklistApp -destination 'platform=macOS' test`
Expected: FAIL (SleepEntry initializer not available in test module)

**Step 3: Write minimal implementation**

- Build Yesterday view with a single toggle row.
- Persist to SwiftData for the selected date.

**Step 4: Run test to verify it passes**

Run: `xcodebuild -project ChecklistApp/ChecklistApp.xcodeproj -scheme ChecklistApp -destination 'platform=macOS' test`
Expected: PASS

**Step 5: Commit**

```bash
git add ChecklistApp/ChecklistApp/Views ChecklistApp/ChecklistApp/ContentView.swift ChecklistApp/ChecklistAppTests/ChecklistAppTests.swift
 git commit -m "feat: yesterday sleep view"
```

### Task 7: Settings view (template management)

**Files:**
- Create: `ChecklistApp/ChecklistApp/Views/SettingsView.swift`
- Modify: `ChecklistApp/ChecklistApp/ContentView.swift`

**Step 1: Write the failing test**

```swift
func testTemplateItemSortOrder() {
    let item = TemplateItem(title: "X", section: .todo, sortOrder: 2)
    XCTAssertEqual(item.sortOrder, 2)
}
```

**Step 2: Run test to verify it fails**

Run: `xcodebuild -project ChecklistApp/ChecklistApp.xcodeproj -scheme ChecklistApp -destination 'platform=macOS' test`
Expected: FAIL (TemplateItem not available in tests)

**Step 3: Write minimal implementation**

- Settings view allows add/remove/edit template items for each section.
- Save changes to SwiftData.

**Step 4: Run test to verify it passes**

Run: `xcodebuild -project ChecklistApp/ChecklistApp.xcodeproj -scheme ChecklistApp -destination 'platform=macOS' test`
Expected: PASS

**Step 5: Commit**

```bash
git add ChecklistApp/ChecklistApp/Views ChecklistApp/ChecklistApp/ContentView.swift ChecklistApp/ChecklistAppTests/ChecklistAppTests.swift
 git commit -m "feat: settings template management"
```

### Task 8: Weekly stats (simplified)

**Files:**
- Create: `ChecklistApp/ChecklistApp/Stats/WeeklyStats.swift`
- Modify: `ChecklistApp/ChecklistApp/Views/TodayView.swift`
- Modify: `ChecklistApp/ChecklistAppTests/ChecklistAppTests.swift`

**Step 1: Write the failing test**

```swift
func testWeeklyStatsCountsDone() {
    let items = [
        DayItem(title: "A", section: .review, status: .done, date: Date())
    ]
    let stats = WeeklyStats.compute(items)
    XCTAssertEqual(stats.totalDone, 1)
}
```

**Step 2: Run test to verify it fails**

Run: `xcodebuild -project ChecklistApp/ChecklistApp.xcodeproj -scheme ChecklistApp -destination 'platform=macOS' test`
Expected: FAIL (WeeklyStats not found)

**Step 3: Write minimal implementation**

- Compute per-template completion counts for the current week.
- Render simple progress bars beneath Today list.

**Step 4: Run test to verify it passes**

Run: `xcodebuild -project ChecklistApp/ChecklistApp.xcodeproj -scheme ChecklistApp -destination 'platform=macOS' test`
Expected: PASS

**Step 5: Commit**

```bash
git add ChecklistApp/ChecklistApp/Stats ChecklistApp/ChecklistApp/Views/TodayView.swift ChecklistApp/ChecklistAppTests/ChecklistAppTests.swift
 git commit -m "feat: weekly stats"
```

### Task 9: GitHub Actions CI (build + artifact)

**Files:**
- Create: `.github/workflows/build-macos.yml`

**Step 1: Write the failing test**

```yaml
name: Build macOS
```

**Step 2: Run test to verify it fails**

Run: `act -W .github/workflows/build-macos.yml`
Expected: FAIL (no jobs defined)

**Step 3: Write minimal implementation**

- Use macOS runner.
- Run `xcodebuild` to build.
- Upload `.app` artifact for preview.

**Step 4: Run test to verify it passes**

Run: `act -W .github/workflows/build-macos.yml`
Expected: PASS

**Step 5: Commit**

```bash
git add .github/workflows/build-macos.yml
 git commit -m "ci: build macOS app"
```
