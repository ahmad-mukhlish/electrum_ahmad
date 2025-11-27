# Bikes List Implementation Plan

## Overview
Create a bikes list feature with Firestore integration that displays available electric bikes for rental. Display as a grid on web and vertical list on mobile, positioned on the Bikes screen. Supports offline cache for viewing bikes without internet connection.

## Architecture Layers

### 1. Domain Layer

#### Entity: Bike
**Location**: `lib/features/bikes/domain/entities/bike.dart`

- Create Freezed entity with:
  - `String id`
  - `String model`
  - `String photoUrl`
  - `int rangeKm`
  - `bool isAvailable`
  - `int pricePerDay`
  - `List<String> pickupAreas` (default: empty list)
- Use `abstract` modifier (Freezed v3.0.0+)
- Include private constructor `const Bike._()` for custom methods

#### UI State: BikeState (Optional)
**Location**: `lib/features/bikes/presentation/viewmodel/states/bike_state.dart`

- Create Freezed class if UI-specific data is needed:
  - `Bike bike` (the base bike entity)
  - Additional UI flags if required (e.g., `bool isSelected`, `bool isFavorite`)
- For now, can use `Bike` entity directly in UI if no UI-specific state needed
- Add later if complexity grows

### 2. Data Layer

#### DTO: BikeDto
**Location**: `lib/features/bikes/data/dtos/bike_dto.dart`

- Create json_serializable DTO with nullable fields:
  - `String? id`
  - `String? model`
  - `@JsonKey(name: 'photo-url') String? photoUrl`
  - `@JsonKey(name: 'range-km') int? rangeKm`
  - `@JsonKey(name: 'is-available') bool? isAvailable`
  - `@JsonKey(name: 'price-per-day') int? pricePerDay`
  - `@JsonKey(name: 'pickup-areas') List<String>? pickupAreas`
- Add `fromJson` and `toJson` methods
- Create extension `BikeDtoMapper` with `toEntity()` method
  - Provide defaults: empty string for strings, 0 for ints, false for bool, empty list for pickupAreas
- Create extension `BikeMapper` in bike.dart entity with `toDto()` method

#### Datasource: BikesFirestoreDatasource
**Location**: `lib/features/bikes/data/datasources/bikes_firestore_datasource.dart`

- Create Riverpod provider that injects `FirebaseFirestore` from `core/services/firebase/firebase_service.dart`
- Implement datasource class with:
  - Constructor accepting `FirebaseFirestore` instance
  - Method `Stream<List<BikeDto>> getBikes()`:
    - Query collection 'bikes'
    - Order by 'model' ascending for consistent alphabetical display
    - Enable offline persistence (via global Firestore settings)
    - Map snapshots to `List<BikeDto>`
    - Wrap in try-catch with rethrow
- Follow existing pattern from `promotions_firestore_datasource.dart`

#### Repository Interface
**Location**: `lib/features/bikes/domain/repositories/bikes_repository.dart`

- Create abstract interface:
  - Method `Stream<List<Bike>> getBikes()`

#### Repository Implementation
**Location**: `lib/features/bikes/data/repositories/bikes_repository_impl.dart`

- Create Riverpod provider that injects datasource
- Implement `BikesRepository` interface:
  - Inject `BikesFirestoreDatasource`
  - Implement `getBikes()`:
    - Call datasource method
    - Map DTOs to entities using `toEntity()`
    - Wrap in try-catch with rethrow
- Follow existing pattern from `data/repositories/promotions/promotions_repository_impl.dart`

### 3. Presentation Layer

#### Provider: Bikes Stream Provider
**Location**: `lib/features/bikes/presentation/viewmodel/notifiers/bikes_provider.dart`

- Create Riverpod stream provider using `@riverpod`:
  - Watch repository provider
  - Return bikes stream
  - Handle async states (loading, data, error)

#### Widget: BikeCard
**Location**: `lib/features/bikes/presentation/widgets/shared/bike_card.dart`

- Create card widget accepting:
  - `Bike bike`
  - `VoidCallback? onTap`
- Display components using builder methods:
  - `_buildImage()` - Bike photo with aspect ratio container
  - `_buildModel()` - Model name as headline
  - `_buildSpecs()` - Range and availability status
  - `_buildPrice()` - Price per day formatted with Rupiah
- Layout:
  - Image on top (use `CachedNetworkImage` or `Image.network`)
  - Content section below with padding
  - Clean, card-like appearance with shadow
- Use `Theme.of(context).textTheme` for text styles
- Use existing `formatPriceToRupiahK` helper from `core/utils/price_formatter.dart`
- Wrap entire card in `GestureDetector` or `InkWell` for tap handling
- Pass minimal data to methods (e.g., pass `TextTheme`, `ColorScheme` instead of `BuildContext`)

#### Widget: BikesList (Mobile)
**Location**: `lib/features/bikes/presentation/widgets/mobile/bikes_list_mobile.dart`

- Create consumer widget with:
  - Watch `bikesProvider`
  - Handle three states:
    - **Loading**: Show loading indicators
    - **Error**: Return `SizedBox.shrink()` and show snackbar
    - **Data**: Display bikes in vertical `ListView`
- Vertical layout:
  - Single column
  - Each `BikeCard` takes full width
  - Spacing between cards: 16px
  - Padding: 24px horizontal
- Error handling:
  - Use `ScaffoldMessenger` to show error snackbar
  - Message: "Error loading bikes"
- Empty state: Show message if no bikes available
- On card tap: Navigate to bike detail (pass bike.id)

#### Widget: BikesList (Web)
**Location**: `lib/features/bikes/presentation/widgets/web/bikes_list_web.dart`

- Create consumer widget with:
  - Watch `bikesProvider`
  - Handle three states (loading, error, data)
- Grid layout:
  - Use `GridView.builder` or `Wrap`
  - Responsive columns: 2-4 columns based on screen width
  - Example: `crossAxisCount: MediaQuery.of(context).size.width > 1200 ? 4 : 2`
  - `crossAxisSpacing`: 16px
  - `mainAxisSpacing`: 16px
  - `childAspectRatio`: Adjust for card proportion
  - Max width constraint: 1200-1400px
  - Center grid on page
- Same error handling as mobile
- On card tap: Navigate to bike detail (pass bike.id)

#### Screen: BikesScreen
**Location**: `lib/features/bikes/presentation/screens/bikes_screen.dart`

- Update existing `BikesScreen` with:
  - For web: Show `HeaderWeb` with title "Bikes"
  - For mobile: Use `PrimaryAppBar` with title "Bikes"
  - Body: Conditional rendering based on platform
    - `kIsWeb ? BikesListWeb() : BikesListMobile()`
  - Background color: `colorScheme.onPrimary`
  - Maintain consistent layout with other screens

## Navigation

### Bike Detail Navigation
**Location**: Throughout bike card taps

- When bike card is tapped:
  - Navigate to bike detail route
  - Pass bike ID as parameter
  - Route: `/bikes/:bikeId`
- Implementation:
  ```dart
  onTap: () {
    context.go('/bikes/${bike.id}');
  }
  ```
- Note: Bike detail screen implementation is in separate brief

## Dependencies

Check `pubspec.yaml` - these should already be available:
```yaml
dependencies:
  cached_network_image: ^3.0.0  # For efficient image loading
  # All other dependencies already present
```

If `cached_network_image` is missing, add it.

## Implementation Order

1. **Domain Layer**:
   - Create `Bike` entity with Freezed
   - Skip `BikeState` for now (add later if needed)

2. **Data Layer**:
   - Create `BikeDto` with json_serializable and mappers
   - Create `BikesFirestoreDatasource`
   - Create repository interface and implementation

3. **Presentation Layer**:
   - Create `bikesProvider` stream provider
   - Create `BikeCard` widget with builder methods
   - Create `BikesListMobile` widget
   - Create `BikesListWeb` widget
   - Update `BikesScreen` to use conditional rendering

4. **Code Generation**:
   - User will run: `dart run build_runner build --delete-conflicting-outputs`

5. **Verification**:
   - User will run: `flutter analyze`

## Error Handling Strategy

- **Datasource Level**: Wrap Firestore operations in try-catch with rethrow
- **Repository Level**: Wrap datasource calls in try-catch with rethrow
- **Presentation Level**: Use AsyncValue states to handle errors
- **UI Level**: Show snackbar on error and hide bikes section

## Layout Specifications

### Mobile Layout
- **Vertical scroll** with bikes stacked
- **Single column** full width
- **16px spacing** between cards
- **24px padding** from screen edges
- **ListView.builder** for performance

### Web Layout
- **Responsive grid** (2-4 columns)
- **Max width constraint** (1200-1400px)
- **16px spacing** between cards (both cross and main axis)
- **Centered** on page
- **GridView.builder** or **Wrap** for responsive layout
- Breakpoints:
  - `< 768px`: 2 columns
  - `768px - 1200px`: 3 columns
  - `> 1200px`: 4 columns

### Card Design
- **Image-focused** layout (reference car list design)
- Image aspect ratio: 16:9 or 4:3
- Clean white card with subtle shadow
- Padding: 16px for content section
- Border radius: 12-16px
- Elevation: 2-4

## Bike Card Content

Display in order:
1. **Image**: Full-width at top with placeholder if loading fails
2. **Model Name**: Headline style, bold
3. **Specs Row**:
   - Range: "Range: XX km" with icon
   - Availability: "Available" (green) or "Not Available" (gray) with icon
4. **Price**: "from Rp. XX.XXXK / day" using `formatPriceToRupiahK`

## Offline Support

- Firestore offline persistence enabled globally
- Bikes cached automatically after first fetch
- Works seamlessly with existing Firebase configuration
- User can view bikes without internet if previously loaded

## Image Handling

- Use `CachedNetworkImage` for efficient loading and caching
- Placeholder: Show shimmer or skeleton while loading
- Error: Show default bike placeholder image or icon
- Fit: `BoxFit.cover` to fill image area

## Navigation Flow

```
BikesScreen (current screen)
  ├─ Mobile: BikesListMobile
  │   └─ BikeCard (tap) → Navigate to /bikes/:bikeId
  └─ Web: BikesListWeb
      └─ BikeCard (tap) → Navigate to /bikes/:bikeId
```

## Notes

- Follow DRY and YAGNI principles
- Use builder methods (_buildX) for widget organization per AGENTS.md
- Pass minimal data to widgets (e.g., pass `Bike` and `VoidCallback` instead of `BuildContext`)
- Use fat arrow `=>` for one-line functions
- Add comments only for critical sections (Firestore mapping, navigation logic)
- Omit unused parameters with single underscore `_`
- Use `HookConsumerWidget` only if managing local state
- DTOs use nullable fields per AGENTS.md pattern
- Mapper extensions follow naming convention: `BikeDtoMapper` and `BikeMapper`
- Reuse existing `formatPriceToRupiahK` helper for price formatting
- No search/filter functionality in this implementation (separate brief)
- Keep focus on clean list display and navigation to detail

### Color Usage
- **NEVER hardcode colors**: Always use `Theme.of(context).colorScheme`
- Use `colorScheme.onSecondary` for dark text (instead of `Colors.black`)
- Use `colorScheme.onPrimary` for light backgrounds (instead of `Colors.white`)
- Use semantic tokens: `colorScheme.primary`, `colorScheme.secondary`, `colorScheme.tertiary`, `colorScheme.error`
- Reference: See AGENTS.md Color Usage section for complete guidelines

### Responsive Text Sizing
- **Text must be larger on web, smaller on mobile**
- Use `kIsWeb` conditional for text styles:
  - Large headings: `kIsWeb ? textTheme.displayMedium : textTheme.headlineSmall`
  - Subheadings: `kIsWeb ? textTheme.headlineLarge : textTheme.bodyLarge`
  - Body text: `kIsWeb ? textTheme.headlineSmall : textTheme.bodyLarge`
- Reference: See AGENTS.md Responsive Text Sizing section and `auth_form.dart` for examples
