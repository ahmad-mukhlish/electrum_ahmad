# Bike Detail Implementation Plan

## Overview

Implement a detailed view for individual bikes that displays comprehensive information and provides a clear CTA for rental interest. The screen will be responsive (mobile and web) and reuse the existing `Bike` entity and Firestore infrastructure.

## File Structure

```
lib/features/bikes/
├── domain/
│   └── entities/
│       └── bike.dart                          # ✅ Already exists
├── data/
│   ├── dtos/
│   │   └── bike_dto.dart                      # ✅ Already exists
│   ├── datasources/
│   │   └── bikes_firestore_datasource.dart    # ✅ Update with getBikeById
│   └── repositories/
│       └── bikes_repository_impl.dart         # ✅ Update with getBikeById
└── presentation/
    ├── viewmodel/
    │   └── notifiers/
    │       └── bike_detail_provider.dart      # 🆕 Family provider for single bike
    ├── screens/
    │   └── bike_detail_screen.dart            # 🆕 Main detail screen
    └── widgets/
        ├── mobile/
        │   └── bike_detail_content_mobile.dart   # 🆕 Mobile layout
        ├── web/
        │   └── bike_detail_content_web.dart      # 🆕 Web layout
        └── shared/
            ├── bike_hero_section.dart         # 🆕 Hero image section
            ├── bike_specs_row.dart            # 🆕 Specs chips
            ├── bike_description_section.dart  # 🆕 Description/features
            ├── bike_service_center_areas.dart # 🆕 Service center chips
            └── bike_cta_button.dart           # 🆕 CTA button
```

## Data Layer Updates

### 1. Datasource (`bikes_firestore_datasource.dart`)

**Add method:** `getBikeById(String bikeId)`
- Returns `Stream<BikeDto?>` from Firestore
- Query: `.collection('bikes').doc(bikeId).snapshots()`
- Map snapshot to BikeDto (null if document doesn't exist)
- Include document ID in the DTO data
- Use try-catch with rethrow pattern

### 2. Repository (`bikes_repository_impl.dart`)

**Add method:** `getBikeById(String bikeId)`
- Returns `Stream<Bike?>`
- Call datasource `getBikeById()`
- Map `BikeDto?` to `Bike?` using `.toEntity()`
- Use try-catch with rethrow pattern

## Presentation Layer

### 1. Provider (`bike_detail_provider.dart`)

**Create:** Family provider using @riverpod annotation
- Parameter: `String bikeId`
- Returns: `Stream<Bike?>`
- Watches `bikesRepositoryProvider`
- Calls repository `getBikeById(bikeId)`
- Auto-disposes when screen closes
- Generate with build_runner

### 2. Main Screen (`bike_detail_screen.dart`)

**Purpose:** Container screen that handles routing and state management

**Constructor:**
- Required parameter: `String bikeId` (from route)

**Build method:**
- Watch `bikeDetailProvider(bikeId)`
- Conditional AppBar: `PrimaryAppBar` (mobile) or `null` (web)
- Conditional HeaderWeb for web platform

**State handling:**
- **Loading:** Show centered CircularProgressIndicator
- **Error:** Show error message with Retry and Back buttons
- **Null data:** Show "Bike not found" with Back button
- **Success:** Show bike detail content (mobile or web layout)

**Responsive:**
- Use kIsWeb to switch between mobile/web content widgets
- Larger spacing and sizing on web

### 3. Mobile Layout (`bike_detail_content_mobile.dart`)

**Structure:**
- SingleChildScrollView for vertical scrolling
- Column layout with all sections stacked
- 16px padding around content
      - Sections: Hero → Specs → Description → Service Center Areas → CTA
- Spacing: 24px between major sections
- Full-width CTA button at bottom

### 4. Web Layout (`bike_detail_content_web.dart`)

**Structure:**
- Center with ConstrainedBox (maxWidth: 1000px)
- SingleChildScrollView with 32px padding
- Column layout same order as mobile
- Larger spacing: 32-48px between sections
- CTA button centered with maxWidth: 400px

### 5. Hero Section (`bike_hero_section.dart`)

**Purpose:** Display bike image, name, and subtitle

**Layout:**
- Container with gradient background (primary color with low alpha → onPrimary)
- Image section: responsive height (400px web, 250px mobile)
- Fallback: two_wheeler icon if no image
- Title: bike.model (displayMedium web, headlineLarge mobile)
- Subtitle: Static text based on model name pattern (e.g., "Urban Commuter", "Electric Scooter")

**Subtitle logic:**
- Check model name for keywords (city, cargo, long range, etc.)
- Return appropriate category string
- Default: "Electric Scooter"

### 6. Specs Row (`bike_specs_row.dart`)

**Purpose:** Display range, availability, and price as chips

**Layout:**
- Wrap widget for responsive wrapping
- Three chips with icon + text:
  1. Range: battery icon + "Range: X km"
  2. Availability: check/cancel icon + "Available" / "Not Available"
  3. Price: payments icon + "from Rp. XK / day"

**Styling:**
- Background: color.withValues(alpha: 0.1)
- Text/icon: semantic colors (primary, error, secondary)
- Use formatPriceToRupiahK for price formatting
- Responsive padding (16/12 horizontal, 12/8 vertical)

### 7. Description Section (`bike_description_section.dart`)

**Purpose:** Show bike features and benefits

**Layout:**
- Section title: "About this bike"
- Feature list (static for now):
  - Zero Emissions → "Environmentally friendly electric motor"
  - Easy to Ride → "Lightweight design suitable for all skill levels"
  - Cost Effective → "Save money on fuel and maintenance costs"
  - Smart Features → "App connectivity and GPS tracking included"

**Feature item structure:**
- Row with check_circle icon + text column
- Title (bold) + description (muted)
- Responsive spacing

### 8. Service Center Areas (`bike_service_center_areas.dart`)

**Purpose:** Display available service center locations

**Layout:**
- Section title: "Available Service Center Areas"
- Wrap layout for area chips
- Each chip: location icon + area name
- Chip styling: tertiary color, rounded borders
- Hidden if serviceCenterAreas list is empty

### 9. CTA Button (`bike_cta_button.dart`)

**Purpose:** Navigate to interest form

**Behavior:**
- Enabled when `bike.isAvailable == true`
- Disabled when `bike.isAvailable == false`
- Label: "I'm interested to rent" (available) or "Not Available" (disabled)
- Icon: favorite/heart icon

**Navigation:**
- On press: `context.go('/bikes/${bike.id}/interest')`
- Pass extra data: bikeId, model, photoUrl
- Use GoRouter for navigation

**Styling:**
- FilledButton.icon with primary color
- Disabled colors: muted onSecondary
- Responsive padding (20px web, 16px mobile)
- Responsive text (headlineSmall web, bodyLarge mobile)

## Routing Updates

### Update `routing.dart`

**Add nested routes under bikes:**
- `/bikes/:bikeId` → BikeDetailScreen
- `/bikes/:bikeId/interest` → InterestFormScreen (placeholder for now)

**Route structure:**
```
/bikes
  → BikesScreen (list)
  /:bikeId
    → BikeDetailScreen (detail)
    /interest
      → InterestFormScreen (future)
```

**Parameter extraction:**
- Use `state.pathParameters['bikeId']!` to get bikeId
- Pass bikeId to BikeDetailScreen constructor

## Implementation Steps

### Phase 1: Data Layer (Foundation)
1. Update `bikes_firestore_datasource.dart` with getBikeById method
2. Update `bikes_repository_impl.dart` with getBikeById method
3. Run build_runner to generate code

### Phase 2: Provider
1. Create `bike_detail_provider.dart` with family provider
2. Run build_runner to generate provider code

### Phase 3: Shared Widgets (Bottom-Up)
1. Create `bike_hero_section.dart`
2. Create `bike_specs_row.dart`
3. Create `bike_description_section.dart`
4. Create `bike_service_center_areas.dart`
5. Create `bike_cta_button.dart`

### Phase 4: Layout Widgets
1. Create `bike_detail_content_mobile.dart` using shared widgets
2. Create `bike_detail_content_web.dart` using shared widgets

### Phase 5: Main Screen
1. Create `bike_detail_screen.dart` with state handling
2. Wire up provider and conditional layouts

### Phase 6: Routing
1. Update `routing.dart` with bike detail routes
2. Update bikes list navigation to use correct route


## Key Design Decisions

### Why Stream Instead of Future?
- Real-time updates: Changes in Firestore reflect immediately
- Consistent with bikes list pattern
- Better user experience (availability changes update automatically)

### Why Family Provider?
- Each bike detail screen is independent
- Proper auto-disposal per bike
- Type-safe parameter passing
- Automatic cache management by Riverpod

### Why Separate Mobile/Web Layouts?
- Different spacing requirements (16px vs 32px)
- Different constraints (full-width vs max-width)
- Different component sizing
- Easier to maintain and modify independently

### Why Static Description?
- Brief.md specifies acceptable for test
- Can be moved to Firestore later
- Keeps initial implementation simple
- Demonstrates UI structure without backend complexity

### Why Separate Shared Widgets?
- Reusability across mobile/web layouts
- Single responsibility per widget
- Easier testing and maintenance
- Clear component boundaries
- Follows "one widget per file" convention

## Color Guidelines

**Reference:** AGENTS.md Color Usage section

- Dark text/icons: `colorScheme.onSecondary`
- Light backgrounds: `colorScheme.onPrimary`
- Primary highlights: `colorScheme.primary`
- Error states: `colorScheme.error`
- Secondary elements: `colorScheme.secondary`
- Tertiary elements: `colorScheme.tertiary`
- Semi-transparent: `.withValues(alpha: 0.1)` for backgrounds

## Responsive Text Guidelines

**Reference:** AGENTS.md Responsive Text Sizing section

- Large headings: `kIsWeb ? displayMedium : headlineLarge`
- Subheadings: `kIsWeb ? headlineSmall : titleLarge`
- Body text: `kIsWeb ? bodyLarge : bodyMedium`
- Always use kIsWeb conditional for platform-specific sizing

## Error Handling Pattern

**All data layer methods:**
- Wrap logic in try-catch blocks
- Use `rethrow` to propagate errors
- Let presentation layer handle error display

**Presentation layer:**
- Use AsyncValue.when() for state handling
- Show user-friendly error messages
- Provide retry and back actions
- Never expose raw error details in production

## Notes

- No new Firestore schema required
- Interest form route prepared but not implemented
- Feature descriptions are static (can enhance later)
- Follow existing bikes list patterns
- Use builder methods (`_buildX`) for widget organization
- Generate all providers with build_runner
- Run `dart run build_runner build --delete-conflicting-outputs` after creating providers
