# Promotions Implementation Plan

## Overview
Create a promotions feature with Firestore integration that displays an auto-scrolling carousel of promotional cards on the home screen for both mobile and web platforms.

## Architecture Layers

### 1. Domain Layer

#### Entity: Promotion
**Location**: `lib/features/home/domain/entities/promotion.dart`

- Create Freezed entity with:
  - `String title` (default: empty string)
  - `String shortCopy` (default: empty string)
  - `String validity` (default: empty string)
- Use `abstract` modifier (Freezed v3.0.0+)
- Include private constructor `const Promotion._()` for future custom methods

### 2. Data Layer

#### DTO: PromotionDto
**Location**: `lib/features/home/data/dtos/promotions/promotion_dto.dart`

- Create Freezed DTO with JSON serialization:
  - `String title`
  - `@JsonKey(name: 'short-copy') String shortCopy`
  - `String validity`
- Add `fromJson` factory for Firestore deserialization
- Create extension `PromotionDtoX` with `toEntity()` method
- Create extension `PromotionX` with `toDto()` method

#### Datasource: PromotionsFirestoreDatasource
**Location**: `lib/features/home/data/datasources/promotions/promotions_firestore_datasource.dart`

- Create Riverpod provider that injects `FirebaseFirestore` from `core/services/firebase/firebase_service.dart`
- Implement datasource class with:
  - Constructor accepting `FirebaseFirestore` instance
  - Method `Stream<List<PromotionDto>> getPromotions()`:
    - Query collection 'promotions'
    - Enable offline persistence (already configured if Firestore settings are set globally)
    - Map snapshots to `List<PromotionDto>`
    - Wrap in try-catch with rethrow for error propagation
- Follow existing pattern from `auth_firebase_datasource.dart`

#### Repository Interface
**Location**: `lib/features/home/domain/repositories/promotions_repository.dart`

- Create abstract interface:
  - Method `Stream<List<Promotion>> getPromotions()`

#### Repository Implementation
**Location**: `lib/features/home/data/repositories/promotions/promotions_repository_impl.dart`

- Create Riverpod provider that injects datasource
- Implement `PromotionsRepository` interface:
  - Inject `PromotionsFirestoreDatasource`
  - Implement `getPromotions()`:
    - Call datasource method
    - Map DTOs to entities using `toEntity()`
    - Wrap in try-catch with rethrow
- Follow existing pattern from `auth_repository_impl.dart`

### 3. Presentation Layer

#### Provider: Promotions Stream Provider
**Location**: `lib/features/home/presentation/viewmodel/promotions_provider.dart`

- Create Riverpod stream provider:
  - Watch repository provider
  - Return promotions stream
  - Handle async states (loading, data, error)

#### Widget: PromotionCard
**Location**: `lib/features/home/presentation/widgets/shared/promotion_card.dart`

- Create card widget accepting:
  - `Promotion promotion`
  - `Color backgroundColor`
- Display:
  - `title` - styled as headline
  - `shortCopy` - styled as body text
  - `validity` - styled as caption
- Background: Use provided color with adjusted alpha for text visibility
- Use `Theme.of(context).textTheme` for text styles
- Ensure text contrast with background color

#### Widget: PromotionsCarousel
**Location**: `lib/features/home/presentation/widgets/shared/promotions_carousel.dart`

- Use `carousel_slider` package (add to pubspec.yaml if missing)
- Create stateful/hook widget with:
  - Watch `promotionsProvider`
  - Handle three states:
    - **Loading**: Show loading indicator or shimmer
    - **Error**: Return `SizedBox.shrink()` and show snackbar with error message
    - **Data**: Build carousel if list is not empty, otherwise return `SizedBox.shrink()`
- Carousel configuration:
  - Auto-scroll enabled
  - Infinite loop if multiple items
  - Aspect ratio suitable for promotion cards
  - Auto-play interval: 3-5 seconds
- Random background colors:
  - Create list of colors: `[colorScheme.primary, colorScheme.secondary, colorScheme.tertiary]`
  - Adjust alpha to 0.7-0.8 for text visibility
  - Cycle through colors
- Error handling:
  - Use `ScaffoldMessenger` to show error snackbar
  - Message: "Error fetching promotions"

#### Screen Update: HomeScreen
**Location**: `lib/features/home/presentation/screens/home_screen.dart`

- Import `PromotionsCarousel`
- Replace placeholder content with:
  - `PromotionsCarousel()` at the top
  - Maintain existing layout structure
  - Use `Column` or `ListView` for layout
  - Add appropriate spacing

## Dependencies

Check and add to `pubspec.yaml` if missing:
```yaml
dependencies:
  carousel_slider: ^5.0.0
```

## Implementation Order

1. **Domain Layer First**:
   - Create `Promotion` entity

2. **Data Layer**:
   - Create `PromotionDto` with JSON annotations
   - Create `PromotionsFirestoreDatasource`
   - Create repository interface and implementation

3. **Presentation Layer**:
   - Create `promotions_provider`
   - Create `PromotionCard` widget
   - Create `PromotionsCarousel` widget
   - Update `HomeScreen`

4. **Code Generation**:
   - User will run: `dart run build_runner build --delete-conflicting-outputs`

5. **Verification**:
   - User will run: `flutter analyze`

## Error Handling Strategy

- **Datasource Level**: Wrap Firestore operations in try-catch with rethrow
- **Repository Level**: Wrap datasource calls in try-catch with rethrow
- **Presentation Level**: Use AsyncValue states to handle errors
- **UI Level**: Show snackbar on error and hide carousel widget

## Offline Support

- Firestore offline persistence should be enabled globally in Firebase initialization
- If not already configured, the datasource will work with cached data automatically
- No explicit cache configuration needed per collection if global persistence is enabled

## Notes

- Follow DRY and YAGNI principles
- Use builder methods (_buildX) for widget organization
- Extract color logic into named function if more than 2 lines
- Pass minimal data to widgets (e.g., pass `Color` and `Promotion` instead of `BuildContext`)
- Use fat arrow `=>` for one-line functions
- Add comments only for critical sections (color selection logic, error handling)
- Omit unused parameters with single underscore `_`
- Use `HookConsumerWidget` if managing local state
