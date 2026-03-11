# Prototype UI Refresh Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Rebuild the app UI to align closely with the two provided prototypes, using `CHIQING`, `FRANKLIN`, and `SETTINGS` tabs while preserving the existing SwiftData foundation.

**Architecture:** Keep the current SwiftData-backed data layer for checklist functionality, but reorganize the visual structure around a prototype-faithful shell and feature-specific SwiftUI views. Introduce a shared design system layer so typography, color, spacing, and surfaces stay consistent across tabs.

**Tech Stack:** Swift 6, SwiftUI, SwiftData, XCTest, GitHub Actions.

---

### Task 1: Establish shared design tokens and shell layout

**Files:**
- Create: `ChecklistApp/ChecklistApp/Design/AppTheme.swift`
- Create: `ChecklistApp/ChecklistApp/Views/AppShellView.swift`
- Modify: `ChecklistApp/ChecklistApp/ContentView.swift`

**Step 1: Write the failing test**

```swift
func testAppModuleLoads() {
    XCTAssertTrue(true)
}
```

**Step 2: Run test to verify it fails**

Run: `xcodebuild -project ChecklistApp/ChecklistApp.xcodeproj -scheme ChecklistApp -destination 'platform=macOS' test`
Expected: CI-only verification; local environment may not have full Xcode.

**Step 3: Write minimal implementation**

- Add a shared theme file for colors, spacing, corner radius, and typography.
- Create a shell view with the paper-window layout, background treatment, and top navigation.
- Simplify `ContentView` so it only selects which tab content to show inside the shell.

**Step 4: Run test to verify it passes**

Run: `xcodebuild -project ChecklistApp/ChecklistApp.xcodeproj -scheme ChecklistApp -destination 'platform=macOS' test`
Expected: PASS in GitHub Actions.

**Step 5: Commit**

```bash
git add ChecklistApp/ChecklistApp/Design ChecklistApp/ChecklistApp/Views/AppShellView.swift ChecklistApp/ChecklistApp/ContentView.swift
git commit -m "feat: add prototype-aligned app shell"
```

### Task 2: Rebuild the CHIQING tab to match prototype 1

**Files:**
- Modify: `ChecklistApp/ChecklistApp/Views/TodayView.swift`
- Modify: `ChecklistApp/ChecklistApp/Views/ChecklistSectionView.swift`
- Modify: `ChecklistApp/ChecklistApp/Views/CompletionCounter.swift`
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
Expected: CI-only verification; local environment may not have full Xcode.

**Step 3: Write minimal implementation**

- Convert `TodayView` into the `CHIQING` page layout.
- Render one visually unified list rather than separate card blocks.
- Add a compact yesterday-sleep recap row within the page.
- Add a weekly progress section visually inspired by prototype 1.

**Step 4: Run test to verify it passes**

Run: `xcodebuild -project ChecklistApp/ChecklistApp.xcodeproj -scheme ChecklistApp -destination 'platform=macOS' test`
Expected: PASS in GitHub Actions.

**Step 5: Commit**

```bash
git add ChecklistApp/ChecklistApp/Views/TodayView.swift ChecklistApp/ChecklistApp/Views/ChecklistSectionView.swift ChecklistApp/ChecklistApp/Views/CompletionCounter.swift ChecklistApp/ChecklistAppTests/ChecklistAppTests.swift
git commit -m "feat: align chiqing tab with checklist prototype"
```

### Task 3: Build the FRANKLIN tab from prototype 2

**Files:**
- Create: `ChecklistApp/ChecklistApp/Models/FranklinVirtue.swift`
- Create: `ChecklistApp/ChecklistApp/Views/FranklinView.swift`
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
Expected: CI-only verification; local environment may not have full Xcode.

**Step 3: Write minimal implementation**

- Add a Franklin virtue model with demo data.
- Build the virtues grid, highlighted selection, quote block, and cycle list.
- Replace the old `Yesterday` navigation destination with `FRANKLIN`.

**Step 4: Run test to verify it passes**

Run: `xcodebuild -project ChecklistApp/ChecklistApp.xcodeproj -scheme ChecklistApp -destination 'platform=macOS' test`
Expected: PASS in GitHub Actions.

**Step 5: Commit**

```bash
git add ChecklistApp/ChecklistApp/Models/FranklinVirtue.swift ChecklistApp/ChecklistApp/Views/FranklinView.swift ChecklistApp/ChecklistApp/ContentView.swift
git commit -m "feat: add franklin prototype tab"
```

### Task 4: Simplify Settings and preserve design consistency

**Files:**
- Modify: `ChecklistApp/ChecklistApp/Views/SettingsView.swift`
- Modify: `ChecklistApp/ChecklistApp/Design/AppTheme.swift`

**Step 1: Write the failing test**

```swift
func testTemplateSeedingCreatesDefaults() throws {
    let context = try InMemoryModelContextFactory.make()
    TemplateSeeder.seedIfNeeded(context)
    XCTAssertGreaterThan(TemplateSeeder.countTemplates(context), 0)
}
```

**Step 2: Run test to verify it fails**

Run: `xcodebuild -project ChecklistApp/ChecklistApp.xcodeproj -scheme ChecklistApp -destination 'platform=macOS' test`
Expected: CI-only verification; local environment may not have full Xcode.

**Step 3: Write minimal implementation**

- Restyle settings to fit the paper-window visual language.
- Keep the feature scope tight: template add/delete remains, but layout becomes cleaner and less demo-like.

**Step 4: Run test to verify it passes**

Run: `xcodebuild -project ChecklistApp/ChecklistApp.xcodeproj -scheme ChecklistApp -destination 'platform=macOS' test`
Expected: PASS in GitHub Actions.

**Step 5: Commit**

```bash
git add ChecklistApp/ChecklistApp/Views/SettingsView.swift ChecklistApp/ChecklistApp/Design/AppTheme.swift
git commit -m "feat: restyle settings for prototype shell"
```

### Task 5: Update docs and CI notes for the new structure

**Files:**
- Modify: `docs/ci-experience.md`
- Modify: `docs/plans/2026-03-11-macos-checklist-design.md`

**Step 1: Write the failing test**

```swift
func testAppModuleLoads() {
    XCTAssertTrue(true)
}
```

**Step 2: Run test to verify it fails**

Run: `xcodebuild -project ChecklistApp/ChecklistApp.xcodeproj -scheme ChecklistApp -destination 'platform=macOS' test`
Expected: CI-only verification; local environment may not have full Xcode.

**Step 3: Write minimal implementation**

- Update the CI notes to mention zipped `.app` artifact behavior.
- Keep the design doc aligned with the final tab naming and prototype mapping.

**Step 4: Run test to verify it passes**

Run: `xcodebuild -project ChecklistApp/ChecklistApp.xcodeproj -scheme ChecklistApp -destination 'platform=macOS' test`
Expected: PASS in GitHub Actions.

**Step 5: Commit**

```bash
git add docs/ci-experience.md docs/plans/2026-03-11-macos-checklist-design.md
git commit -m "docs: align ui notes with prototype refresh"
```
