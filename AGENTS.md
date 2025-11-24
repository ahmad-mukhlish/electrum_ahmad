# Electrum Ahmad

Flutter mobile application.

## Tech Stack

- Flutter 3.x
- Dart SDK ^3.9.2
- State Management: Riverpod (2 skill available)

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

```bash
flutter run          # Run app
flutter test         # Run tests
flutter analyze      # Lint check
flutter build apk    # Build Android
flutter build ios    # Build iOS
```

## Conventions

- Skills stored in `.claude/skills`; use both available skills when applicable
