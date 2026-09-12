# Harraka

Harraka is a quick-commerce  grocery delivery app built with Flutter — order groceries and everyday essentials and get them delivered to your door in minutes.

## Features

- Browse categories, search products, and view detailed product pages
- Cart and checkout with address, payment, and order summary steps
- Live order tracking with rider status updates
- Order history, saved addresses, wallet & offers, and push notifications
- Splash and onboarding flow into OTP-based authentication

## Tech Stack

- **Framework:** Flutter (Dart)
- **Architecture:** Feature-first + Clean Architecture (`data` / `domain` / `presentation` layers per feature)
- **State Management:** Riverpod
- **Networking:** Dio
- **Local Storage:** SharedPreferences (cart cache, session tokens)
- **Backend:** PostgreSQL (external service)

See [`Docs/Harraka_setup.md`](Docs/Harraka_setup.md) for the full project structure and design token reference (colors, typography, spacing) used throughout the app.

## Project Structure

```
lib/
├── main.dart / app.dart      # Entry point, theme & routing injection
├── core/                     # Shared constants, theme, network, routing, widgets
├── features/                 # One folder per feature (auth, home, cart, checkout, ...)
├── config/                   # Environment configuration (dev/staging/prod)
└── l10n/                     # Localization
```

Every feature follows the same `data / domain / presentation` layering, and shares code only through `core/` — no feature imports another feature's internals directly.

## Getting Started

1. Install [Flutter](https://docs.flutter.dev/get-started/install) (this project targets the stable channel).
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```
4. Run tests:
   ```bash
   flutter test
   ```

