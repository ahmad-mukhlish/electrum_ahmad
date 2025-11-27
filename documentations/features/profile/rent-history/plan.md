# Rent History Implementation Plan

## Overview
Implement a read-only rent history feature in the Profile page, showing user's past and current bike rental submissions with list and detail views.

---

## Architecture Layers

### 1. Data Layer (`features/bikes/data/`)

#### Datasource
- Extend existing datasource to support querying user-specific rents
- Add method to fetch rents filtered by user (contactEmail or userId)
- Query Firestore `rents` collection with:
  - Filter: by current user's identifier
  - Order: by `createdAt` descending
- Handle empty results gracefully
- Wrap all datasource methods in try-catch with rethrow for error propagation

#### DTO
- Reuse existing `RentDto` if available
- Ensure all fields from brief are mapped:
  - id, bikeId, bikeModel, photoUrl
  - fromDate, toDate
  - pickupArea, locationAddress
  - contactName, contactPhone, contactEmail
  - totalPrice, createdAt, status
- Use `@JsonSerializable` for JSON conversion
- All fields nullable in DTO to handle incomplete data

#### Repository
- Add method to get user's rent history
- Delegate to datasource for Firestore query
- Map DTOs to domain entities
- Apply try-catch with rethrow pattern

### 2. Domain Layer (`features/bikes/domain/`)

#### Entity
- Reuse existing `Rent` entity (Freezed model)
- Verify it contains all required fields from brief
- Use `@freezed` with `abstract` modifier
- Ensure immutability with Freezed

### 3. Presentation Layer (`features/bikes/presentation/`)

#### View Model / Notifier (`viewmodel/notifiers/`)

**RentHistoryNotifier**
- AsyncNotifierProvider to fetch and hold rent history list
- Build method: fetch user's rents via repository
- Returns `List<Rent>` wrapped in AsyncValue
- Auto-dispose when not in use
- No mutation methods needed (read-only)

#### UI State (`viewmodel/states/`)

**RentHistoryItemState**
- Freezed class extending `Rent` with pre-calculated UI values
- Fields to add:
  - formattedDateRange (string like "12 Jan - 15 Jan 2025")
  - totalDays (int calculated from fromDate to toDate)
  - formattedPrice (string like "Rp 320.000")
  - statusLabel (string: "Pending" / "Confirmed" / "Completed")
  - statusColor (ColorScheme property name for badge color)
- Factory method: `fromEntity(Rent rent)` to compute all values
- Keep calculation logic centralized for consistency

#### Screens (`screens/`)

**Profile Screen Updates**
- Remove lottie widget section below user name/email
- Remove lottie dependency from pubspec.yaml
- Add RentHistory widget in that location
- Widget watches `rentHistoryProvider`
- Handle three AsyncValue states:
  - Loading: show loading indicator
  - Error: show error message with retry button
  - Data: show list or empty state

#### Widgets (`widgets/mobile/`, `widgets/shared/`)

**RentHistoryList** (shared)
- Receives `List<RentHistoryItemState>` from parent
- Mobile: vertical list of cards
- Web: centered column with increased padding (use kIsWeb)
- Empty state: icon/illustration + "No rentals yet..." message
- Maps each item to RentHistoryCard

**RentHistoryCard** (shared)
- Displays compact summary for one rent
- Layout:
  - Left: small thumbnail (photoUrl, 60-80px square)
  - Right: column with:
    - Model name (title style)
    - Date range + total days (body style)
    - Pickup area (caption style)
    - Total price (emphasized)
    - Status badge (chip/container with color)
- Responsive text sizing (kIsWeb pattern)
- Use theme colors only (colorScheme)
- OnTap: navigate to detail view with selected rent
- Reuse card styling from bike list (shadow, rounded corners)

**RentDetailView** (mobile or shared)
- Can be bottom sheet OR full page (decision during implementation)
- Receives single `Rent` object as parameter
- Sections to display:
  - Header: bike model + larger photo
  - Date section: full fromDate and toDate with time
  - Location: pickupArea + full locationAddress
  - Contact: name, phone, email
  - Price: totalPrice + breakdown if available
  - Status: badge with label
  - Footer: "Requested on [createdAt]"
- Use same theme/typography patterns as payment summary
- Close button or back navigation

---

## File Structure

New files to create:
```
lib/features/bikes/
  presentation/
    viewmodel/
      notifiers/
        rent_history_notifier.dart         # AsyncNotifierProvider
        rent_history_notifier.g.dart       # Generated
      states/
        rent_history_item_state.dart       # UI state
        rent_history_item_state.freezed.dart
    widgets/
      shared/
        rent_history_list.dart             # List container
        rent_history_card.dart             # Single item card
        rent_detail_view.dart              # Detail screen/sheet
```

Files to modify:
```
lib/features/bikes/data/
  datasources/
    bike_remote_datasource.dart            # Add user rent query
  repositories/
    bike_repository.dart                   # Add getUserRents method

lib/features/profile/presentation/screens/
  profile_screen.dart                      # Remove lottie, add RentHistory

pubspec.yaml                               # Remove lottie dependency
```

---

## Implementation Steps

### Phase 1: Data Layer Setup
1. Add Firestore query method in datasource for user's rents
   - Filter by contactEmail or userId
   - Order by createdAt desc
   - Use try-catch with rethrow
2. Add repository method to fetch user rents
   - Call datasource method
   - Map DTOs to Rent entities
   - Use try-catch with rethrow

### Phase 2: Presentation Logic
1. Create RentHistoryItemState
   - Define Freezed class with UI fields
   - Implement fromEntity factory method
   - Add utility methods for date/price formatting
   - Calculate totalDays, format dates, format price
   - Map status to label and color
2. Create RentHistoryNotifier
   - Use @riverpod annotation
   - AsyncNotifierProvider pattern
   - Fetch rents via repository
   - Map to RentHistoryItemState list

### Phase 3: UI Components
1. Create RentHistoryCard widget
   - HookConsumerWidget or ConsumerWidget
   - Compact card layout with thumbnail + info
   - Status badge with theme colors
   - Responsive text sizing
   - OnTap callback to parent
2. Create RentHistoryList widget
   - Receives list of RentHistoryItemState
   - Handle empty state with illustration
   - Platform-specific padding (kIsWeb)
   - Map items to cards
3. Create RentDetailView widget
   - Full rent information display
   - All fields from brief
   - Responsive layout
   - Theme colors and typography

### Phase 4: Integration
1. Update Profile screen
   - Remove lottie widget section
   - Remove lottie dependency from pubspec
   - Add RentHistory section below user info
   - Watch rentHistoryProvider
   - Handle AsyncValue states (loading, error, data)
   - Pass selected rent to detail view on tap
2. Wire up navigation
   - Decide: bottom sheet vs full page for detail
   - Implement navigation from card tap
   - Pass Rent object to detail view

### Phase 5: Polish
1. Error handling
   - Non-blocking error display
   - Retry button for failed loads
   - Preserve screen visibility on error
2. Loading states
   - Show loading indicator on initial fetch
   - Consider shimmer for better UX
3. Testing considerations
   - Manual test with empty history
   - Manual test with multiple rents
   - Manual test error scenarios
   - Verify responsive behavior on web
4. Cleanup
   - Remove lottie imports
   - Run dart format
   - Verify no lottie references remain

---

## Design Guidelines

### Typography
- Use theme textTheme with responsive sizing
- Large headings: `kIsWeb ? displayMedium : headlineSmall`
- Body text: `kIsWeb ? headlineSmall : bodyLarge`
- Apply pattern from auth_form.dart

### Colors
- Use `Theme.of(context).colorScheme` exclusively
- Status badge colors:
  - Pending: colorScheme.secondary or tertiary
  - Confirmed: colorScheme.primary
  - Completed: colorScheme.onSecondary with opacity
- Never use Colors.white, Colors.black, or hardcoded hex values

### Spacing & Layout
- Card padding: 12-16px
- Card margin: 8-12px vertical
- Thumbnail size: 60-80px square
- Card elevation: reuse from bike list cards
- Web: add horizontal padding constraints (max width ~800px)

### Formatting Utilities
- Date range: "12 Jan - 15 Jan 2025"
- Total days: calculate difference, format as "X days"
- Price: "Rp xxx.xxx" with thousand separators
- Reuse existing formatters if available in utils

---

## Dependencies Check

Required (already in project):
- flutter_riverpod or hooks_riverpod
- riverpod_annotation + riverpod_generator
- freezed + freezed_annotation
- cloud_firestore (for Firestore queries)

To remove:
- lottie (from pubspec.yaml)

---

## Notes & Considerations

### Data Access
- Only read from `rents` collection (no writes)
- Filter strictly to current user's rents
- Use existing auth provider to get current user identifier
- Consider caching strategy if needed (auto-dispose default is fine)

### Error Scenarios
- Network failure: show retry button
- Empty results: show friendly empty state
- Parse errors: catch in datasource, show error state

### Performance
- Firestore query is limited by user filter (naturally scoped)
- Consider pagination if user has many rents (future enhancement)
- Use const constructors where possible
- Optimize with ref.select if watching specific fields

### Accessibility
- Ensure tappable areas are at least 48x48
- Use semantic labels for status badges
- Provide text alternatives for icons

### Future Enhancements (not in scope)
- Pull to refresh
- Filtering by status
- Search within history
- Cancel/modify rent from history
- Pagination for large histories

---

## Success Criteria

- ✅ Profile page shows rent history below user info
- ✅ Lottie widget and dependency removed
- ✅ List displays all required fields compactly
- ✅ Detail view shows complete rent information
- ✅ Empty state displayed when no rents exist
- ✅ Error state handled gracefully with retry
- ✅ Loading state shown during fetch
- ✅ Status badge colors differentiate rent states
- ✅ Responsive on both mobile and web
- ✅ Theme colors used throughout (no hardcoded colors)
- ✅ Code follows project conventions (DRY, YAGNI, clean architecture)
