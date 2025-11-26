# Plans Implementation Plan

## Overview
Create a plans feature with Firestore integration that displays subscription plans with dynamic pricing calculations. Display horizontally on web and vertically on mobile, positioned below the promotions carousel.

## Architecture Layers

### 1. Domain Layer

#### Entity: Plan
**Location**: `lib/features/home/domain/entities/plan.dart`

- Create Freezed entity with:
  - `int id`
  - `String name`
  - `String tagline`
  - `int pricePerDay`
  - `int pricePerWeek`
  - `int pricePerMonth`
  - `String bestFor`
  - `List<String> terms` (default: empty list)
  - `String hexColor` (default: 'FFFFFFFF' for white)
- Use `abstract` modifier (Freezed v3.0.0+)
- Include private constructor `const Plan._()` for custom methods

#### UI State: PlanUIState
**Location**: `lib/features/home/domain/entities/plan_ui_state.dart`

- Create Freezed class with:
  - `Plan plan` (the base plan entity)
  - `double percentagePlanDiscountWeekly` (calculated discount for weekly vs daily)
  - `double percentagePlanDiscountMonthly` (calculated discount for monthly vs daily)
- Factory constructor to create from Plan entity
- Calculations:
  ```dart
  percentageWeekly = ((pricePerDay * 7 - pricePerWeek) / (pricePerDay * 7)) * 100
  percentageMonthly = ((pricePerDay * 30 - pricePerMonth) / (pricePerDay * 30)) * 100
  ```

### 2. Data Layer

#### DTO: PlanDto
**Location**: `lib/features/home/data/dtos/plan_dto.dart`

- Create json_serializable DTO with nullable fields:
  - `int? id`
  - `String? name`
  - `String? tagline`
  - `@JsonKey(name: 'price-per-day') int? pricePerDay`
  - `@JsonKey(name: 'price-per-week') int? pricePerWeek`
  - `@JsonKey(name: 'price-per-month') int? pricePerMonth`
  - `@JsonKey(name: 'best-for') String? bestFor`
  - `List<String>? terms`
  - `@JsonKey(name: 'hex-color') String? hexColor`
- Add `fromJson` and `toJson` methods
- Create extension `PlanDtoMapper` with `toEntity()` method
  - Provide defaults: empty string for strings, 0 for ints, empty list for terms, 'FFFFFFFF' for hexColor
- Create extension `PlanMapper` in plan.dart entity with `toDto()` method

#### Datasource: PlansFirestoreDatasource
**Location**: `lib/features/home/data/datasources/plans_firestore_datasource.dart`

- Create Riverpod provider that injects `FirebaseFirestore` from `core/services/firebase_service.dart`
- Implement datasource class with:
  - Constructor accepting `FirebaseFirestore` instance
  - Method `Stream<List<PlanDto>> getPlans()`:
    - Query collection 'plans'
    - Order by 'id' ascending for consistent display order
    - Enable offline persistence (via global Firestore settings)
    - Map snapshots to `List<PlanDto>`
    - Wrap in try-catch with rethrow
- Follow existing pattern from `promotions_firestore_datasource.dart`

#### Repository Interface
**Location**: `lib/features/home/domain/repositories/plans_repository.dart`

- Create abstract interface:
  - Method `Stream<List<Plan>> getPlans()`

#### Repository Implementation
**Location**: `lib/features/home/data/repositories/plans_repository_impl.dart`

- Create Riverpod provider that injects datasource
- Implement `PlansRepository` interface:
  - Inject `PlansFirestoreDatasource`
  - Implement `getPlans()`:
    - Call datasource method
    - Map DTOs to entities using `toEntity()`
    - Wrap in try-catch with rethrow
- Follow existing pattern from `promotions_repository_impl.dart`

### 3. Presentation Layer

#### Provider: Plans Stream Provider
**Location**: `lib/features/home/presentation/viewmodel/plans_provider.dart`

- Create Riverpod stream provider:
  - Watch repository provider
  - Return plans stream
  - Handle async states (loading, data, error)

#### Provider: Plans UI State Provider
**Location**: `lib/features/home/presentation/viewmodel/plans_ui_state_provider.dart`

- Create Riverpod provider that transforms plans to UI states:
  - Watch `plansProvider`
  - Map `List<Plan>` to `List<PlanUIState>`
  - Calculate discount percentages for each plan

#### Widget: PlanCard
**Location**: `lib/features/home/presentation/widgets/shared/plan_card.dart`

- Create card widget accepting:
  - `PlanUIState planState`
  - `Color backgroundColor` (converted from hexColor)
- Display components using builder methods:
  - `_buildHeader()` - Plan name and icon
  - `_buildTagline()` - Best for description
  - `_buildPricing()` - Price with discount badge
  - `_buildSubscribeButton()` - Action button
  - `_buildTerms()` - Bullet list of features/terms
- Use `Theme.of(context).textTheme` for text styles
- Pass minimal data to methods (e.g., pass `TextTheme`, `Color` instead of `BuildContext`)

#### Widget: PlansSection (Mobile)
**Location**: `lib/features/home/presentation/widgets/mobile/plans_section_mobile.dart`

- Create stateless/hook widget with:
  - Watch `plansUIStateProvider`
  - Handle three states:
    - **Loading**: Show shimmer or loading indicators
    - **Error**: Return `SizedBox.shrink()` and show snackbar
    - **Data**: Display plans vertically in a `Column`
- Vertical layout:
  - Each `PlanCard` takes full width
  - Spacing between cards: 16px
  - Convert hexColor to Color using helper
- Error handling:
  - Use `ScaffoldMessenger` to show error snackbar
  - Message: "Error fetching plans"

#### Widget: PlansSection (Web)
**Location**: `lib/features/home/presentation/widgets/web/plans_section_web.dart`

- Create stateless/hook widget with:
  - Watch `plansUIStateProvider`
  - Handle three states (loading, error, data)
- Horizontal layout:
  - Use `Row` with `mainAxisAlignment: MainAxisAlignment.spaceEvenly`
  - Wrap in `ConstrainedBox` with max width for proper spacing
  - Each `PlanCard` wrapped in `Expanded` or `Flexible`
  - Spacing between cards: 16px
  - Convert hexColor to Color using helper
- Same error handling as mobile

#### Update: HomeContentMobile
**Location**: `lib/features/home/presentation/widgets/mobile/home_content_mobile.dart`

- Add `PlansSectionMobile` below `PromotionsCarousel`
- Maintain proper spacing (24-32px)

#### Update: HomeContentWeb
**Location**: `lib/features/home/presentation/widgets/web/home_content_web.dart`

- Add section title "Plans" with `headlineLarge` style
- Add `PlansSectionWeb` below promotions section
- Maintain proper spacing and max-width constraints

### 4. Utilities

#### Helper: HexColor Converter
**Location**: `lib/core/utils/color_helper.dart`

- Create utility class/function to convert hex string to Color:
  ```dart
  Color hexToColor(String hexString) {
    // Remove # if present
    final hex = hexString.replaceAll('#', '');

    // Add FF for alpha if not present (6 digits)
    final fullHex = hex.length == 6 ? 'FF$hex' : hex;

    // Parse and return Color
    return Color(int.parse(fullHex, radix: 16));
  }
  ```
- Handle edge cases:
  - Invalid hex strings (return default white)
  - Missing alpha channel
  - Add error handling with try-catch

## Implementation Order

1. **Utils First**:
   - Create `HexColor` converter utility

2. **Domain Layer**:
   - Create `Plan` entity
   - Create `PlanUIState` entity with discount calculations

3. **Data Layer**:
   - Create `PlanDto` with JSON annotations and mappers
   - Create `PlansFirestoreDatasource`
   - Create repository interface and implementation

4. **Presentation Layer**:
   - Create `plans_provider`
   - Create `plans_ui_state_provider`
   - Create `PlanCard` widget with builder methods
   - Create `PlansSectionMobile` widget
   - Create `PlansSectionWeb` widget
   - Update `HomeContentMobile`
   - Update `HomeContentWeb`

5. **Code Generation**:
   - User will run: `dart run build_runner build --delete-conflicting-outputs`

6. **Verification**:
   - User will run: `flutter analyze`

## Error Handling Strategy

- **Datasource Level**: Wrap Firestore operations in try-catch with rethrow
- **Repository Level**: Wrap datasource calls in try-catch with rethrow
- **Presentation Level**: Use AsyncValue states to handle errors
- **UI Level**: Show snackbar on error and hide plans section

## Layout Specifications

### Mobile Layout
- **Vertical scroll** with plans stacked
- **Full width** cards
- **16px spacing** between cards
- **24px padding** from screen edges

### Web Layout
- **Horizontal row** with equal width cards
- **Max width constraint** (800-1000px recommended)
- **16px spacing** between cards
- **Centered** on page
- **24px padding** from container edges

## Discount Calculation Logic

```dart
// Example:
// Daily: $10, Weekly: $60, Monthly: $200
// Weekly discount = ((10 * 7) - 60) / (10 * 7) * 100 = 14.3%
// Monthly discount = ((10 * 30) - 200) / (10 * 30) * 100 = 33.3%
```

## Offline Support

- Firestore offline persistence enabled globally
- Plans cached automatically
- Works seamlessly with existing Firebase configuration

## Notes

- Follow DRY and YAGNI principles
- Use builder methods (_buildX) for widget organization per AGENTS.md
- Extract color logic into named function if more than 2 lines
- Pass minimal data to widgets (e.g., pass `Color` and `PlanUIState` instead of `BuildContext`)
- Use fat arrow `=>` for one-line functions
- Add comments only for critical sections (discount calculations, color conversion)
- Omit unused parameters with single underscore `_`
- Use `HookConsumerWidget` if managing local state
- DTOs use nullable fields per AGENTS.md pattern
- Mapper extensions follow naming convention: `PlanDtoMapper` and `PlanMapper`
