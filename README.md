# 🧪 iOS Clean Architecture Test – Developer Guide

Hi there! 👋

This project demonstrates how to build a modular, testable iOS app using **MVVM + Clean Architecture**. Below is everything I followed (and recommend) to meet the exercise goals — from tools and architecture to testing and implementation practices.

## Issues Found 

Area    Issue
SOLID Principles    ✅ Mostly followed, but Endpoint is very loosely defined (S/I Violations).
Architecture    ❌ Clean Architecture not fully enforced (e.g. UseCase/Entity layers are thin or missing).
Async Handling    ❌ Using PromiseKit, not Swift Concurrency (async/await) or Combine.
Presentation Layer    ❌ UIKit-based likely; no SwiftUI or Combine.
Testing    ❌ No unit tests or mocks visible.
Helpers/Utils    ✅ Minimal, but could use centralization.
Modularization    ❌ Everything lives in a monolithic app module.


---

## 🛠 Tools & Libraries

- **PromiseKit** – for async API handling.
- **SPM / CocoaPods** – used for dependency management.
- No use of **Combine** or **Singletons** to keep the code clean and test-friendly.

---

## 🧱 Architecture Overview

This app uses a layered, Clean Architecture setup:

```
Presentation (UIKit ViewController + Storyboard)
↓
ViewModel
↓
UseCase
↓
Repository
↓
Service
↓
Network (URLSession + PromiseKit)
```

Everything is protocol-driven and injected manually, making the app easy to test and maintain.

---

## ✅ Testing Strategy

### Unit Tests

- Every class/module has **at least one unit test**
- Focused heavily on testing:
  - ViewModel logic
  - UseCase forwarding
  - Repository behavior
  - Service calls with mocked clients

### Test Coverage

- Achieved **80%+** coverage across modules using `XCTest`

### Bonus Tests

- ✅ **Snapshot Tests** using `iOSSnapshotTestCase`
- ✅ **UI Tests** using `XCTest` to verify interaction and navigation

---

## 🧩 Implementation Notes

### Presentation Layer

- Implemented using **Storyboard** with:
  - A **Search Bar**
  - A **TableView** to display results
- Auto Layout is applied to ensure responsiveness
- Navigates to a **Detail ViewController** with a coin summary

### ViewModel

- Handles UI state + communication with UseCase
- Implements protocol delegation back to the view
- Fully tested with mock UseCase

### UseCase

- Acts as a pure pass-through layer
- Converts data-layer models to domain models (if needed)
- Contains no logic and is 100% test-covered

### Repository

- Talks to Service and returns transformed data
- Written to be **fully mockable**

### Service

- Encapsulates networking logic and API endpoints
- Injected with a shared `NetworkClient` (no hard-coded URLs inside services)

### Network Layer

- Built using `URLSession` + `PromiseKit`
- Uses a generic decoder for all `Codable` responses
- Logs errors cleanly (but strips in production)

---

## 🛡 Security, Config & Debugging

- **No Singletons** – all dependencies are injected manually
- Used `Info.plist` and environment-specific schemes for configs
- Sensitive data: store in **Keychain**
- Non-sensitive preferences: stored in `UserDefaults`
- Debug logging: uses `OSLog` (disabled in release builds)
- Optimized API response with **image caching** via `NSCache`
- Zero force unwraps — everything is safely unwrapped with `guard` / `if let`

---

## 🧪 Snapshot & UI Testing Details

### Snapshot Tests

- Use `FBSnapshotTestCase` to validate layout
- Reference images stored under `CryptoTrackerTests/ReferenceImages_64/`
- Run once in `recordMode = true` to capture images

### UI Tests

- Basic tests include:
  - Verifying crypto list loads
  - Tapping on a coin cell navigates to detail
- Tests use `XCUIApplication` and built-in assertions

---
