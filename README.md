<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.38+-02569B?logo=flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-3.11+-0175C2?logo=dart&logoColor=white" alt="Dart">
  <img src="https://img.shields.io/badge/platform-macOS%20%7C%20Windows%20%7C%20Linux%20%7C%20iOS%20%7C%20Android-lightgrey" alt="Platforms">
  <img src="https://img.shields.io/badge/architecture-Clean%20Architecture-blueviolet" alt="Architecture">
  <img src="https://img.shields.io/badge/license-MIT-green" alt="License">
</p>

# Paste Tool

A lightweight, keyboard-driven desktop companion for **quick phrase snippets** and **todo notes**. Built with Flutter and Clean Architecture.

---

## ✨ Features

### 📋 Quick Phrases
- Organize text snippets into **folders** (categories) with horizontal chip navigation
- **One-tap copy** — tap any phrase to copy it to clipboard instantly
- **Visual copy feedback** — green checkmark on the copied card
- **Paste from clipboard** — insert text directly from system clipboard
- **Inline search** — `Ctrl+F` to find phrases, `Esc` to dismiss
- **Undo delete** — restore accidentally removed phrases

### ✅ Todo Notes
- Create named **lists** with checkbox items
- **Edit** tasks inline with a tap or pencil button
- **Undo delete** for both lists and tasks
- Auto-sorting: pending first, completed last

### 🎨 UI
- **Light & dark themes** — toggle with one click
- **Pin on top** — keep the window above all others (desktop)
- **Keyboard shortcuts** throughout — no mouse required
- **Responsive** — works from compact mobile to wide desktop
- Persistent **last-tab memory** — reopens where you left off

### ⌨️ Shortcuts

| Context | Keys | Action |
|---|---|---|
| Phrases | `Ctrl+N` | New phrase |
| Phrases | `Ctrl+F` | Search phrases |
| Phrases | `Ctrl+V` | Paste from clipboard |
| Phrases | `Esc` | Clear / close search |
| Todo lists | `Ctrl+N` | New list |
| Todo items | `Ctrl+N` | New task |
| Todo items | `Esc` | Back to lists |

---

## 🏗 Architecture

```
lib/
├── core/
│   ├── di/                  # Manual dependency injection
│   └── theme/               # Light & dark ThemeData
├── data/
│   ├── collections/         # Isar DB collections (ORM)
│   └── repositories/        # Repository implementations
├── domain/
│   ├── entities/            # Pure domain models
│   ├── repositories/        # Abstract repository contracts
│   └── usecases/            # Business logic use cases
└── presentation/
    ├── providers/           # ChangeNotifier view-models
    ├── routes/              # go_router pages & widgets
    │   ├── copy/            # Quick phrases screen
    │   └── todo/            # Todo lists screen
    └── widgets/             # Shared widgets & mixins
```

**Stack:** Flutter · Provider · go_router · Isar Community DB · window_manager · SharedPreferences

41 Dart source files · 4 domain entities · 4 repositories · 4 use cases

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) ≥ 3.38
- For desktop: macOS, Windows, or Linux with Flutter desktop enabled

### Run

```bash
# Clone
git clone <repo-url> && cd paste_tool

# Install dependencies
flutter pub get

# Generate Isar code (after schema changes)
flutter pub run build_runner build --delete-conflicting-outputs

# Run on desktop
flutter run -d macos    # macOS
flutter run -d windows  # Windows
flutter run -d linux    # Linux

# Analyze
flutter analyze
```

---

## 📦 Dependencies

| Package | Purpose |
|---|---|
| `provider` | State management |
| `go_router` | Declarative routing with bottom nav |
| `isar_community` | Local NoSQL database |
| `path_provider` | App documents directory |
| `shared_preferences` | Persist last-active tab |
| `window_manager` | Always-on-top pin mode |
| `uuid` | Unique IDs for entities |

---

## 📄 License

MIT
