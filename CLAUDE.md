# VRoute

Flutter campus guide app for Abdullah Gül University (AGU), Kayseri, Turkey.

## Stack
- Flutter / Dart ^3.5.3
- Firebase Auth, Firestore, Storage
- OpenWeatherMap API (key in `weather_page.dart`)
- ARCore (`arcore_flutter_plugin`) — UI placeholder ready, needs 3D assets
- `google_fonts`, `intl`, `flutter_local_notifications`

## Run & Build
```
flutter pub get
flutter run
flutter analyze   # must be clean before committing
```

## Architecture (feature/ui-redesign branch)
- Entry: `lib/main.dart` → `/splash` → auth check → `/main` or `/login`
- `MainShell` (`lib/pages/main_shell.dart`): `IndexedStack` with 5 tabs + floating bottom nav
- Tabs: Home · Facilities · Weather · Community · Settings
- Detail pages push on top of the shell navigator: FacilityDetail, AboutAGU, AboutVRoute, AR, Puzzles
- Theme toggle: global `ValueNotifier<ThemeMode> themeNotifier` in `main.dart`
- Design tokens: `lib/theme/app_colors.dart` and `lib/theme/app_theme.dart`
- Shared widgets: `lib/widgets/` — glass_card, gradient_scaffold, primary_button, vroute_bottom_nav

## Branch Strategy
- `main` — original working version, stable baseline
- `feature/ui-redesign` — glassmorphism redesign, open PR to merge into main

## Rules
- Never commit `google-services.json` or `GoogleService-Info.plist` (already in .gitignore).
- AR page is a UI placeholder — do not remove the camera permission logic, it will be wired up once campus 3D assets are provided.
- The puzzle unlock mechanism (hidden "Do Not Touch" button in Other Mentions facility) must be preserved in all redesigns.
