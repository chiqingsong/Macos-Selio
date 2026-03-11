# macOS Checklist App Design (SwiftData)

Date: 2026-03-11

## Goals
- Native macOS checklist app in Swift.
- Local data storage with SwiftData.
- Primary features:
  - Today: Review checklist + Todo checklist.
  - Yesterday: sleep recap (slept before midnight).
- UI style aligned to the first provided prototype (list-based).
- No accounts, sync, or notifications.

## Non-Goals
- Cloud sync, multi-device accounts.
- iOS support.
- App Store release workflow.

## Target Platform
- macOS 15+ only (user uses latest macOS).

## Prototypes
- List-based reference (selected): `docs/assets/prototype-1.jpg`
- Alternate reference: `docs/assets/prototype-2.jpg`

## Information Architecture
- Top navigation: Today / Yesterday / Settings.
- Today view:
  - Section: Today Review (checklist).
  - Section: Today Todo (checklist).
  - Header shows done/total (excluding removed items).
- Yesterday view:
  - Single item: "Slept before midnight".
- Settings view:
  - Manage templates for Review and Todo.
  - Default placeholder items, user can add/remove/reorder.

## Data Model (SwiftData)
- TemplateItem
  - id: UUID
  - title: String
  - section: enum (review | todo)
  - sortOrder: Int
- DayItem
  - id: UUID
  - date: Date (day-level)
  - section: enum (review | todo)
  - title: String
  - status: enum (done | notDone | removed)
  - templateId: UUID? (optional link to template)
- SleepEntry
  - date: Date (day-level)
  - sleptBeforeMidnight: Bool

## Daily Generation Rules
- On first open each day, generate DayItem list from TemplateItem.
- Default status for new DayItem is notDone.
- User may add or remove items for that day.
  - Removal sets status to removed (not counted in totals).

## UI Behavior
- Checklist row: checkbox + title + right-side status text (Done/—).
- Remove action: marks as removed (not counted in completion).
- Completion header: done/total (excluding removed).
- Weekly stats (simplified): per-template weekly completion count with progress bars.

## Error Handling
- If SwiftData store fails to load, show a non-blocking error banner and allow retry.
- If daily generation fails, leave list empty and provide a regenerate action.

## Testing Strategy
- Unit tests for:
  - Daily generation from templates.
  - Completion counts excluding removed.
  - Weekly stats calculation.

## CI Preview Plan
- GitHub Actions macOS runner builds the app and uploads `.app` artifact for preview.
- User installs the `.app` locally to preview (no local Xcode required).

## Open Questions (resolved in conversation)
- Yesterday only tracks "slept before midnight".
- Today has two sections (Review + Todo) with template-backed items.
