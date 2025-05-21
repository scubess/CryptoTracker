[![iOS starter workflow](https://github.com/scubess/CryptoTracker/actions/workflows/ios.yml/badge.svg)](https://github.com/scubess/CryptoTracker/actions/workflows/ios.yml)

# ✅ CryptoTracker – Architecture Challenge Completion

This repository demonstrates the completion of the architecture challenge using two different approaches in separate branches:

## 🔀 Branch Comparison

### 1. `main` branch (`CryptoTracker + MVVM MVI`)

- Implemented using **SwiftUI** and **Combine**
- Follows **MVVM-MVI** architecture for clear state management
- Emphasizes reactive programming patterns
- Suitable for modern Swift projects using declarative UI

### 2. `mvvm_clean_architecture` branch (`CryptoTracker MVVM + Clean`)

- Built as a **UIKit + Storyboard** project
- Refactored to follow **MVVM** with **Clean Architecture**
- Achieved strong **modularity** and **SOLID principle** adherence
- Emphasized layer separation (Presentation, Domain, Data)
- Fully unit tested with some UI test coverage

---

## ✅ Achievements

### ✅ SOLID Principles

- Classes follow Single Responsibility and Open/Closed principles
- Interfaces defined for services to enable dependency inversion

### ✅ Clean Architecture

- Separated layers:
  - `Presentation` (ViewControllers + ViewModels)
  - `Domain` (UseCases + Entities)
  - `Data` (Network + Repositories)

### ✅ Modular Design

- Business logic and UI logic are clearly separated
- Easy to swap components or scale features

## 🛡 Security, Config & Debugging

- **No Singletons** – all dependencies are injected manually
- Used `Info.plist` and environment-specific schemes for configs
- Sensitive data: store in **Keychain**
- Non-sensitive preferences: stored in `UserDefaults`
- Debug logging: uses `OSLog` (disabled in release builds)
- Optimized API response with **image caching** via `NSCache`
- Zero force unwraps — everything is safely unwrapped with `guard` / `if let`
- Configure default github runner for iOS tests and attach badge

### ✅ SwiftUI + Combine (in `main`)

- Implemented state-driven UI with SwiftUI views
- Used Combine for reactive data binding

### ✅ UIKit + Storyboard (in `mvvm_clean_architecture`)

- Implemented UI programmatically using UIKit and Storyboard
- Ideal for legacy and production UIKit apps

### ✅ Tests

- Unit tests written for:
  - ViewModels
  - UseCases
  - Services
- UI tests for:
  - Navigation flows
  - View visibility/assertions

---
