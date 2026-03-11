# macOS Checklist App CI Experience

Date: 2026-03-11

## What worked
- GitHub Actions on `macos-15` can build and test a hand-written SwiftUI macOS project.
- Uploading a raw `.app` bundle works, but artifact download and unzip can flatten the app bundle in confusing ways.
- Uploading a zipped app bundle is clearer for manual preview on another Mac.

## Failures and fixes
- Failure: `module 'ChecklistApp' was not compiled for testing`
  - Cause: the app target `Debug` configuration did not enable testability.
  - Fix: set `ENABLE_TESTABILITY = YES` and `SWIFT_OPTIMIZATION_LEVEL = -Onone` for Debug.

- Failure: `Undefined symbols ... ChecklistApp ...` while linking `ChecklistAppTests`
  - Cause: the test bundle was not linked against the built app executable.
  - Fix: set `TEST_HOST`, `BUNDLE_LOADER`, `TEST_TARGET_NAME`, and test runpath settings.

- Confusion: downloaded artifact did not look like a `.app`
  - Cause: GitHub artifact handling preserved the bundle as files rather than a user-friendly zip.
  - Fix: zip `ChecklistApp.app` with `ditto` before upload.

## Current workflow behavior
- Run tests with `xcodebuild test`
- Build a Debug app bundle
- Zip `ChecklistApp.app`
- Upload `ChecklistApp.app.zip` as the artifact

## Recommendations
- Keep macOS CI on the feature branch while the hand-written `.xcodeproj` stabilizes.
- Prefer explicit Xcode build settings over relying on implicit defaults.
- Treat CI as the source of truth when local Xcode is unavailable.
