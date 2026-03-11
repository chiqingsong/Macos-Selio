# macOS Checklist App Design (Prototype-Aligned)

Date: 2026-03-11

## Goals
- Build a native macOS checklist app in SwiftUI with SwiftData persistence.
- Match the provided prototypes as closely as possible rather than using generic SwiftUI layouts.
- Keep the app personal-only: no accounts, sync, sharing, or notifications.

## Non-Goals
- App Store release flow.
- iOS support.
- Multi-user workflows.
- Cloud sync.

## Target Platform
- macOS 15+ only.

## Prototypes
- Main checklist reference: `docs/assets/prototype-1.jpg`
- Franklin tab reference: `docs/assets/prototype-2.jpg`

## Information Architecture
- Top navigation is the primary identity of the app and should match the prototype:
  - `CHIQING`
  - `FRANKLIN`
  - `SETTINGS`
- `CHIQING` maps to prototype 1.
- `FRANKLIN` maps to prototype 2.
- `SETTINGS` remains functional and simpler, but uses the same visual system.

## Page Mapping
### CHIQING
- Large paper-window layout with:
  - top date bar
  - prototype-style tab strip
  - Today checklist area
  - weekly progress area
- The checklist visually reads as one vertical list, even if data is logically grouped.
- "Slept before midnight" is part of this page rather than a standalone tab.
- Review and todo remain separate in data, but should not feel like two unrelated cards.

### FRANKLIN
- Recreate the second prototype as a full tab, not a secondary detail page.
- Top section:
  - 13-virtue grid
  - highlighted current virtue
- Middle section:
  - selected virtue title and quote/explanation
- Bottom section:
  - cycle list with pass/fail style marks
- Use demo data first, but structure it so the data can later move into SwiftData.

### SETTINGS
- Manage CHIQING template items.
- Manage app preferences later, but keep the first version minimal.
- Visual style should still sit inside the same paper-window system.

## Data Model
- Keep existing SwiftData foundation:
  - `TemplateItem`
  - `DayItem`
  - `SleepEntry`
- Extend later only if Franklin data needs persistence.
- For the first Franklin pass, local in-code demo data is acceptable if the UI matches the prototype.

## Visual System
- The app should feel like a soft physical desktop artifact:
  - foggy city backdrop
  - warm paper main panel
  - rounded macOS window silhouette
  - muted gray/brown body text
  - restrained orange highlight color
  - monospaced/typewriter-like typography
- Avoid stock SwiftUI panel-card aesthetics.
- Use shared design constants for:
  - colors
  - spacing
  - corner radius
  - typography
  - shadows

## Interaction Model
- Tab switching should feel instant and lightweight.
- Checklist rows:
  - click checkbox to toggle
  - removed items should disappear from visible totals
- Franklin grid:
  - selecting a virtue updates the text and lower cycle status area
- No heavy animation system is needed, but transitions should feel intentional.

## Error Handling
- If SwiftData fails, preserve a readable shell UI and show a simple fallback message.
- If daily generation fails, show an empty state rather than crashing.

## Testing Strategy
- Keep logic tests around:
  - completion counts
  - template seeding
  - daily generation
- UI layout fidelity is primarily verified by CI build success plus manual artifact review.

## CI Preview Plan
- GitHub Actions builds and tests the app.
- CI uploads a zipped `.app` bundle so the app can be downloaded and previewed on another Mac without local Xcode.

## Approved Decisions
- Rename the first tab from `SOFISH` to `CHIQING`.
- Treat the second prototype as the `FRANKLIN` tab, not as a secondary or optional screen.
- Optimize toward a near 1:1 prototype match rather than preserving the earlier placeholder information architecture.
