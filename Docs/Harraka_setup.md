# Harraka — Flutter Project Structure & Theme Reference

> Quick-commerce (Blinkit-style) delivery app.
> Use this document as the source of truth for scaffolding the Flutter project — folder structure, naming, and theme/design tokens.

---

## 1. Tech Stack

- **Framework:** Flutter (Dart)
- **Architecture:** Feature-first + Clean Architecture layering (data / domain / presentation)
- **State Management:** Riverpod (recommended) or Bloc — pick one and stay consistent across features
- **Backend:** PostgreSQL (existing schema already designed separately)
- **Networking:** Dio / Retrofit-style API layer
- **Local storage:** Hive / SharedPreferences (cart cache, session tokens)

---

## 2. Folder Structure

```
harraka/
├── android/
├── ios/
├── assets/
│   ├── images/
│   ├── icons/
│   ├── fonts/
│   └── lottie/
├── lib/
│   ├── main.dart
│   ├── app.dart                        # MaterialApp root, theme injection, routing
│   │
│   ├── core/
│   │   ├── constants/
│   │   │   ├── app_colors.dart         # <-- theme color tokens (see section 3)
│   │   │   ├── app_text_styles.dart
│   │   │   ├── app_spacing.dart
│   │   │   └── app_strings.dart
│   │   ├── theme/
│   │   │   ├── app_theme.dart          # ThemeData(light/dark) built from tokens
│   │   │   └── theme_extension.dart
│   │   ├── network/
│   │   │   ├── api_client.dart
│   │   │   ├── api_endpoints.dart
│   │   │   └── interceptors/
│   │   ├── error/
│   │   │   ├── failures.dart
│   │   │   └── exceptions.dart
│   │   ├── utils/
│   │   │   ├── validators.dart
│   │   │   ├── formatters.dart         # currency, date, distance
│   │   │   └── extensions/
│   │   ├── routing/
│   │   │   ├── app_router.dart
│   │   │   └── route_names.dart
│   │   └── widgets/                    # shared/reusable dumb widgets
│   │       ├── app_button.dart
│   │       ├── app_text_field.dart
│   │       ├── app_bottom_sheet.dart
│   │       ├── product_card.dart
│   │       ├── shimmer_loader.dart
│   │       └── empty_state.dart
│   │
│   ├── features/
│   │   ├── splash/
│   │   ├── onboarding/
│   │   ├── auth/
│   │   │   ├── data/
│   │   │   │   ├── models/
│   │   │   │   └── repositories/
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   └── usecases/
│   │   │   └── presentation/
│   │   │       ├── screens/            # login, otp, signup
│   │   │       ├── widgets/
│   │   │       └── providers/          # or bloc/
│   │   ├── home/
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   │       ├── screens/            # home_screen.dart
│   │   │       ├── widgets/            # banner_carousel, category_grid, deal_section
│   │   │       └── providers/
│   │   ├── search/
│   │   ├── category/
│   │   ├── product_details/
│   │   ├── cart/
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   │       ├── screens/
│   │   │       ├── widgets/            # cart_item_tile, price_summary
│   │   │       └── providers/
│   │   ├── checkout/
│   │   │   ├── address/
│   │   │   ├── payment/
│   │   │   └── order_summary/
│   │   ├── order_tracking/
│   │   │   └── presentation/
│   │   │       └── widgets/            # live_map_view, rider_status_timeline
│   │   ├── order_history/
│   │   ├── profile/
│   │   ├── addresses/
│   │   ├── wallet_offers/
│   │   └── notifications/
│   │
│   ├── l10n/                           # localization (if multi-language)
│   └── config/
│       ├── env/
│       │   ├── dev.dart
│       │   ├── staging.dart
│       │   └── prod.dart
│       └── app_config.dart
│
├── test/
│   ├── features/
│   └── core/
├── pubspec.yaml
└── README.md
```

**Rules for the agent:**
- Every `feature/` folder follows the same 3-layer pattern: `data/`, `domain/`, `presentation/`.
- No feature imports another feature's internals directly — share via `core/` only.
- All colors, text styles, and spacing must be pulled from `core/constants/`, never hardcoded inside widgets.

---

## 3. Theme Data (Design Tokens)

**Brand direction:** modern, trustworthy, fast — warm red as primary (signals speed/appetite without feeling alarming), paired with a clean neutral base and a green accent for order-status/success states.

### Color Palette

| Token | Hex | Usage |
|---|---|---|
| `primary` | `#E8442A` | Brand color, CTAs, active tab, key buttons |
| `primaryDark` | `#B8301A` | Pressed/hover states, app bar (if colored) |
| `primaryLight` | `#FDEDE9` | Backgrounds, badges, subtle highlights, selected chip bg |
| `secondary` (success/delivery) | `#1FAA59` | Order confirmed, in-transit, delivered states |
| `secondaryLight` | `#E6F7ED` | Success banners/backgrounds |
| `warning` | `#F5A623` | Low stock, delay notices |
| `error` | `#D93A3A` | Form errors, failed payment/order |
| `textPrimary` | `#1A1A1A` | Headings, primary body text |
| `textSecondary` | `#6B6B6B` | Subtext, captions, timestamps |
| `textDisabled` | `#B0B0B0` | Disabled labels |
| `background` | `#FFFFFF` | Screen background |
| `surface` | `#F7F7F8` | Cards, list tiles, input fields |
| `border` | `#E5E5E5` | Dividers, outlines |
| `overlay` | `#000000` @ 40% opacity | Bottom sheet / modal scrim |

### `app_colors.dart` (reference implementation)

```dart
import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFFE8442A);
  static const Color primaryDark = Color(0xFFB8301A);
  static const Color primaryLight = Color(0xFFFDEDE9);

  static const Color secondary = Color(0xFF1FAA59);
  static const Color secondaryLight = Color(0xFFE6F7ED);

  static const Color warning = Color(0xFFF5A623);
  static const Color error = Color(0xFFD93A3A);

  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B6B6B);
  static const Color textDisabled = Color(0xFFB0B0B0);

  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF7F7F8);
  static const Color border = Color(0xFFE5E5E5);

  static const Color overlayScrim = Color(0x66000000); // 40% black
}
```

### Typography

| Style | Size | Weight | Usage |
|---|---|---|---|
| `displayLarge` | 28 | Bold | Splash/onboarding headlines |
| `headingLarge` | 22 | Bold | Screen titles |
| `headingMedium` | 18 | SemiBold | Section headers (e.g. "Deals for you") |
| `bodyLarge` | 16 | Regular | Product names, primary text |
| `bodyMedium` | 14 | Regular | Descriptions, secondary text |
| `caption` | 12 | Regular | Timestamps, delivery ETA, labels |
| `button` | 16 | SemiBold | Button labels |

Recommended font: **Inter** or **Poppins** — both read as clean/modern/trustworthy for commerce UI.

### Spacing Scale (`app_spacing.dart`)

```dart
class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
}
```

### Radius & Elevation

| Token | Value | Usage |
|---|---|---|
| `radiusSmall` | 8 | Chips, small buttons |
| `radiusMedium` | 12 | Cards, product tiles |
| `radiusLarge` | 20 | Bottom sheets, modals |
| `elevationCard` | 2 | Product cards |
| `elevationModal` | 8 | Bottom sheets |

### ThemeData Assembly (`app_theme.dart` sketch)

```dart
ThemeData lightTheme = ThemeData(
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.background,
  colorScheme: ColorScheme.light(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    error: AppColors.error,
    surface: AppColors.surface,
  ),
  fontFamily: 'Inter',
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.background,
    foregroundColor: AppColors.textPrimary,
    elevation: 0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
);
```

---

## 4. Notes for the Agent

1. Scaffold the folder tree exactly as in Section 2 before writing any screen code.
2. Create `app_colors.dart`, `app_text_styles.dart`, `app_spacing.dart` first — every subsequent widget references these, never raw hex/values.
3. Use `secondary` (green) exclusively for positive order-status states so it doesn't compete with the red brand color.
4. Keep `primary` red reserved for CTAs and brand moments — don't overuse it across large surfaces, or it stops feeling premium and starts feeling loud.