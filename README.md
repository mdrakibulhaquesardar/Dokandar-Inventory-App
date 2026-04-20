# BizDash – Flutter Business Admin UI Kit

<p align="center">
  <img src="assets/icon_bg_remove_with_name.png" alt="BizDash Logo" width="200"/>
</p>

## Overview

BizDash is a **pure Flutter UI Kit** for building modern business, admin, and management applications. It includes ready-to-use screens, reusable components, and clean navigation – all powered by static mock data.

**Important:** BizDash is **not** a complete or functional application. There is **no backend**, **no database**, **no authentication**, and **no business logic**. Everything is UI-only.

## Included Screens

BizDash focuses on a clean, generic business-admin flow that reviewers and buyers expect:

1. **Login (UI only)** – Simple sign-in style screen using the existing setup flow (no auth logic).
2. **Forgot Password (UI only)** – Basic form for entering email/phone and showing a success message.
3. **Dashboard** – Summary cards (mock metrics), a simple chart section, and recent activities list.
4. **Records List** – Generic list/table screens for items/records/contacts (inventory-style UIs renamed visually).
5. **Create / Edit Record** – Bottom sheets and forms for adding/updating items and contacts (UI only; shows mock success).
6. **Reports & Analytics** – KPI cards + date filters + static chart-style sections.
7. **Profile** – User profile card with avatar, name, email, and basic edit actions.
8. **Settings** – Theme, language, notification toggles, and workspace-style settings.
9. **Notifications** – Simple notification list with read/unread styling and empty state.
10. **Components Showcase** – Dedicated screen demonstrating buttons, inputs, cards, badges, dialogs, bottom sheets, and states.
11. **Empty / Error States** – Designed "no data", "no internet" and "something went wrong" examples.
12. **Search / Filter Modal** – Reusable search/filter patterns wired from list screens via icons and bottom sheets.

## What You Get

- **Dashboard UI** (cards, metrics, recent items)
- **List screens** (items, contacts, expenses, employees, partners)
- **Detail & edit sheets** (bottom sheets / dialogs)
- **Forms** (add / edit style forms – UI only)
- **Reports & analytics UI** (summary cards & filters)
- **Settings & profile screens**
- **Notifications list UI**
- **Components & states showcase screen**
- **Multi-language-ready UI** (Bengali & English strings included)
- **Light/Dark theme system**

All data is loaded from static mock data files and can be easily replaced with your own API or database layer.

## What Is NOT Included

BizDash is intentionally limited to keep it CodeCanyon-friendly and easy to integrate:

- ❌ No authentication logic (login is UI-only)
- ❌ No database or local storage (no Isar, no SQLite, no Hive)
- ❌ No API integration (no HTTP client, no networking)
- ❌ No POS / checkout / billing / payment logic
- ❌ No real reporting engine (charts are static/mock)
- ❌ No real PDF invoice generation logic (only UI)
- ❌ No real data backup / restore (UI-only examples)

If you need a production-ready app, you must connect these UIs to your own backend or local database.

## Tech Stack

- **Framework**: Flutter 3.x
- **Language**: Dart 3.x
- **State Management**: GetX (for routing & simple reactive state)
- **Theming**: Custom light/dark themes via `AppThemeConfig`
- **Localization**: Flutter localization + ARB files (BN/EN)

## Folder Structure (UI Kit)

```text
lib/
├── app/
│   ├── config/        # App & theme config
│   ├── data/          # Plain Dart models (no Isar)
│   ├── modules/       # Feature-based UI modules (screens + controllers)
│   ├── routes/        # Navigation routes
│   ├── utils/         # Helpers
│   ├── views/         # Main shell view
│   └── widgets/       # Reusable widgets
├── mock/              # Mock data & mock data service
├── l10n/              # Localization files
└── main.dart          # Entry point
```

## Mock Data Layer

All demo content is powered by:

- `lib/mock/mock_data.dart` – static lists for items, contacts, activities, etc.
- `lib/mock/mock_data_service.dart` – async-style API that returns mock data

You can replace this layer with your own repository/API and keep the UI intact.

## Customization

- **Colors & Theme**: Update `lib/app/config/app_theme_config.dart` and `lib/app/config/app_config.dart` for branding.
- **Strings**: Edit ARB files in `lib/l10n/` or the generated localization files.
- **Mock Data**: Edit `lib/mock/mock_data.dart` to change demo content.

## Getting Started

```bash
flutter pub get
flutter run
```

No extra setup is required because there is no database or backend.

## For CodeCanyon Reviewers

- This item is a **UI Kit / UI Template** only.
- There is **no backend**, **no database**, **no authentication**, and **no business logic**.
- All screens listed above are accessible for demo purposes.
- All data is static and in-memory.

## License

This project is a commercial item intended for marketplaces like CodeCanyon. Please refer to the marketplace license terms for allowed usage.
