# Electrum Ahmad

Flutter mobile application targeting mobile and web, with platform-specific widgets split for clarity.

## Tech Stack

- Flutter 3.x
- Dart SDK ^3.9.2
- State management: Riverpod
- Primary datasource : Firebase Auth and Firestore

## Why Riverpod?

- Modern, compile-safe state management that pairs cleanly with `go_router`; GetX brings its own router, which conflicts with that approach.
- Less boilerplate and ceremony than Bloc while staying testable and explicit.
- Keeps dependency injection light and composable as features grow.

## Why Firebase Auth and Firestore?

This is a frontend/mobile take-home, so I chose to go all-in on Firebase Auth + Cloud Firestore.
The focus is on app architecture, UX, and state management rather than building a custom backend. 
All Firebase data access is still funneled through clean architecture and only resides in data layer.
Backend could be swapped later without changing other layers.


## Project Structure (following clean architecture with MVVM pattern)

```
lib/
  core/
    services/                   # Dio, Firebase (Firestore), Secure Storage
    utils/                      # Helpers, Design tokens
    widgets/                    # Shared widgets
  features/
    auth/
      data/
        dtos/                   # JSON annotated dtos from datasources
        repositories/           # Provider, wire to datasources 
        datasources/            # Data providers (Wrapper to API services / Local services) 
      domain/
        entities/               # Business Entity (Model)
      presentation/
        viewmodel/
          notifiers/            # Notifiers (View model)
          states/               # Freezed UI states
        screens/                # Screen (View)
        widgets/
          mobile/               # Widgets tailored for mobile
          web/                  # Widgets tailored for web
  main.dart                     # App entry point
```

## Commands

- `flutter run` — Run app
- `flutter test` — Run tests
- `flutter analyze` — Lint check
- `flutter build apk` — Build Android
- `flutter build ios` — Build iOS

## Notes

- Widgets under `features/todos/presentation/widgets` are split into `mobile` and `web`; import the appropriate one in pages based on platform.

