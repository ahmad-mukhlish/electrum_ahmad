# Bikes Filter & Search Implementation Plan

## Overview

Extend the existing Bikes List with in-memory filtering and search capabilities. The implementation follows clean architecture with MVVM pattern, keeping the current Firestore stream as the single source of truth and deriving a filtered view from filter state.

## Architecture

### Core Principles
- **Single source of truth**: Existing `bikesProvider` continues to stream bikes from Firestore
- **In-memory filtering**: No new Firestore queries when filters change
- **Derived state pattern**: Combine full bikes list + filter state → filtered bikes view
- **Separation of concerns**: Filter logic centralized, UI consumes filtered view

### Data Flow
```
Firestore → bikesProvider (Stream<List<Bike>>)
                    ↓
         bikeFilterProvider (filter state)
                    ↓
      filteredBikesProvider (derived filtered view)
                    ↓
                   UI
```

## File Structure

### Domain Layer (No changes required)
- Entity `Bike` already has all required fields:
  - `model` for search
  - `isAvailable` for availability filter
  - `pricePerDay` for price bucket filter
  - `rangeKm` for range bucket filter

### Presentation Layer - ViewModel

#### New Filter State
**File**: `lib/features/bikes/presentation/viewmodel/states/bike_filter_state.dart`
- Freezed class representing current filter criteria
- Fields:
  - `searchQuery` (String) - for model name search
  - `showAvailableOnly` (bool) - availability toggle
  - `selectedPriceBucket` (PriceBucket? enum/sealed class) - Budget/Premium/Deluxe or null for all
  - `selectedRangeBucket` (RangeBucket? enum/sealed class) - Short/Medium/Long or null for all
- Factory constructor with default values (all filters off)
- Helper method to check if any filter is active

#### Price & Range Bucket Enums
**File**: Same as filter state or separate if preferred
- `PriceBucket` sealed class with three cases:
  - Budget (≤30k)
  - Premium (30k-60k)
  - Deluxe (>60k)
- `RangeBucket` sealed class with three cases:
  - Short (<80km)
  - Medium (80-110km)
  - Long (>110km)
- Each case includes helper method to check if a value falls within the bucket

#### Filter State Notifier
**File**: `lib/features/bikes/presentation/viewmodel/notifiers/bike_filter_provider.dart`
- Riverpod StateNotifier or Notifier managing `BikeFilterState`
- Methods to update each filter:
  - `setSearchQuery(String query)`
  - `toggleAvailability(bool value)`
  - `setPriceBucket(PriceBucket? bucket)`
  - `setRangeBucket(RangeBucket? bucket)`
  - `resetFilters()` - resets to default state
- Provides `activeFilterCount` getter for UI badge

#### Filtered Bikes Provider
**File**: `lib/features/bikes/presentation/viewmodel/notifiers/filtered_bikes_provider.dart`
- Riverpod provider that watches both `bikesProvider` and `bikeFilterProvider`
- Returns `AsyncValue<List<Bike>>` - preserving loading/error states from source
- Core filtering logic:
  1. Start with full bikes list from `bikesProvider`
  2. Apply search filter (case-insensitive substring on `model`)
  3. Apply availability filter if active
  4. Apply price bucket filter if selected
  5. Apply range bucket filter if selected
  6. Return filtered list
- All filters use AND logic (bikes must match all active filters)

### Presentation Layer - UI Widgets

#### Mobile Widgets

**File**: `lib/features/bikes/presentation/widgets/mobile/bikes_search_bar.dart`
- Search text field with:
  - Hint text: "Search your next ride"
  - Search icon prefix
  - Clear button suffix when text is entered
  - Calls filter provider's `setSearchQuery` on change

**File**: `lib/features/bikes/presentation/widgets/mobile/bikes_filter_button.dart`
- Outlined button with filter icon
- Shows active filter count badge when filters are applied (e.g., "Filter (2)")
- Opens filter bottom sheet on tap

**File**: `lib/features/bikes/presentation/widgets/mobile/bikes_filter_sheet.dart`
- Modal dialog containing:
  - Section: Availability toggle
  - Section: Price bucket chips/radio buttons
  - Section: Range bucket chips/radio buttons
  - Bottom actions: Reset and Apply buttons
- Manages local state for staging filter changes
- Only updates filter provider when Apply is tapped
- Reset button calls filter provider's `resetFilters()`

**File**: `lib/features/bikes/presentation/widgets/mobile/bikes_list_with_filters_mobile.dart`
- Replaces current `BikesListMobile` widget
- Column layout:
  - Search bar
  - Filter button
  - Expanded list of bikes
- Consumes `filteredBikesProvider` instead of `bikesProvider`
- Handles states:
  - Loading: shows spinner
  - Error: shows error snackbar
  - Empty (no bikes at all): "No bikes available"
  - Empty (no matches): "No bikes match your search/filters" with option to reset
- Reuses existing `BikeCard` component

#### Web Widgets

**File**: `lib/features/bikes/presentation/widgets/web/bikes_filter_panel.dart`
- Right sidebar panel (fixed width, scrollable)
- Contains vertically stacked:
  - Search field (same as mobile, different styling)
  - Availability toggle section
  - Price bucket section (radio buttons or chips)
  - Range bucket section (radio buttons or chips)
  - Results count label: "Showing X bikes"
  - Reset filters button
- Updates filter provider in real-time (no Apply button needed on web)
- Each filter change immediately reflects in the bikes grid

**File**: `lib/features/bikes/presentation/widgets/web/bikes_list_with_filters_web.dart`
- Replaces current `BikesListWeb` widget
- Row layout:
  - Main content (bikes grid, taking majority of width)
  - Right sidebar (filter panel, ~300-350px width)
- Bikes grid:
  - Consumes `filteredBikesProvider`
  - 2-3 column responsive grid (same as current)
  - Reuses existing `BikeCard` component
- Handles same states as mobile (loading/error/empty/no-matches)

#### Shared Filter Components (Optional)

**File**: `lib/features/bikes/presentation/widgets/shared/price_bucket_selector.dart`
- Reusable widget for selecting price bucket
- Takes current selection and callback
- Renders as chips or radio buttons based on parameter
- Used by both mobile sheet and web panel

**File**: `lib/features/bikes/presentation/widgets/shared/range_bucket_selector.dart`
- Same pattern as price bucket selector
- For range bucket selection

**File**: `lib/features/bikes/presentation/widgets/shared/availability_toggle.dart`
- Reusable toggle/checkbox for availability filter
- Takes current value and callback
- Used by both mobile sheet and web panel

### Screen Updates

**File**: `lib/features/bikes/presentation/screens/bikes_screen.dart`
- Update to use new filtered list widgets:
  - Mobile: `BikesListWithFiltersMobile`
  - Web: `BikesListWithFiltersWeb`
- No other changes required

## Implementation Steps

### Phase 1: State & Logic
1. Create bucket enums (PriceBucket, RangeBucket) with bucket-checking logic
2. Create BikeFilterState freezed class with all filter fields
3. Create BikeFilterProvider notifier with methods to update filters
4. Create FilteredBikesProvider that combines bikes + filters
5. Run build_runner to generate freezed/riverpod code

### Phase 2: Mobile UI
1. Build BikesSearchBar widget
2. Build filter selector components (price, range, availability)
3. Build BikesFilterSheet bottom sheet with staged changes
4. Build BikesFilterButton with badge indicator
5. Build BikesListWithFiltersMobile combining search, filter button, and list
6. Handle empty states (no bikes vs no matches)

### Phase 3: Web UI
1. Build filter selector components (reuse mobile or create web-specific if needed)
2. Build BikesFilterPanel sidebar
3. Build BikesListWithFiltersWeb with Row layout
4. Handle responsive grid and empty states

### Phase 4: Integration
1. Update BikesScreen to use new filtered list widgets
2. Test filter combinations (search + availability + buckets)
3. Test empty states across different scenarios
4. Test reset functionality
5. Verify no Firestore queries triggered by filter changes

### Phase 5: Polish
1. Add smooth transitions when filters change
2. Ensure proper spacing and alignment (mobile & web)
3. Verify accessibility (labels, focus management)
4. Test on different screen sizes
5. Verify all theme colors are used correctly (no hardcoded colors)

## Key Implementation Notes

### Filter Logic Centralization
- All filtering logic lives in `FilteredBikesProvider`
- Adding a new filter requires changes in only three places:
  1. Add field to `BikeFilterState`
  2. Add method to `BikeFilterProvider`
  3. Add filtering logic in `FilteredBikesProvider`
- UI components only call filter provider methods, never filter directly

### Empty State Differentiation
- "No bikes available" → bikesProvider returned empty list (Firestore has no bikes)
- "No bikes match your search/filters" → bikes exist, but filtered list is empty
- Provide "Reset filters" action in the second case

### Mobile Filter UX
- Filter changes are staged in bottom sheet's local state
- Only apply to provider when user taps Apply
- Cancel/dismiss sheet discards changes
- Show active filter count on button: "Filter (2)"

### Web Filter UX
- No Apply button needed - changes apply immediately
- Right sidebar remains visible at all times
- Results count updates in real-time: "Showing 12 bikes"
- Smooth grid updates when filters change

### Bucket Calculation
- Bucket enums/classes contain the boundary logic
- No need to store bucket values in Firestore
- Each bike is categorized on-the-fly during filtering

### Performance
- Since filtering is in-memory on already-loaded bikes, performance should be excellent
- Even with hundreds of bikes, filtering should be instant
- No debouncing required for search (can filter on every keystroke)

### Responsive Design
- Mobile: Vertical layout, modal filter sheet, list view
- Web: Horizontal layout with sidebar, grid view, real-time filtering
- Text sizes follow existing responsive patterns (kIsWeb checks)

## Dependencies

### No new packages required
- Existing Riverpod handles all state management
- Existing Freezed handles immutable state classes
- No external filter/search libraries needed

## Notes on Extensibility

### Future Filter Ideas (Out of Scope)
- Filter by pickup areas
- Sort options (price low-to-high, range high-to-low)
- Saved filter presets
- URL-based filter state (deep linking)
- Filter persistence across sessions

### Adding New Filters
Pattern to follow when adding a new filter:
1. Add field to BikeFilterState
2. Add setter method to BikeFilterProvider
3. Add UI control to filter sheet/panel
4. Add filtering logic to FilteredBikesProvider
5. All existing code continues to work


### Edge cases:
- All bikes filtered out (no matches)
- Very long search query
- Rapid filter changes
- Filter state when navigating away and back
