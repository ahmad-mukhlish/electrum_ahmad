# Bike Renting Form Implementation Plan

> ⚠️ **IMPORTANT**: This plan contains NO code implementations. It describes WHAT needs to be done, not HOW. Code will be written during implementation.

## Overview

Implement a checkout-style bike renting form that captures user intent to rent, calculates total payment, and persists the rent order to Firestore. The screen is responsive (mobile/web) and includes geolocation features, contact prefilling, and payment summary.

## Dependencies to Add

Add these packages to `pubspec.yaml`:

1. **quickalert** - Success/error dialogs
2. **geolocator** - Location permission and current position
3. **geocoding** - Reverse geocoding (lat/lng to address)
4. **shared_preferences** - Store user contact info locally (if not already added)

## File Structure

```
lib/features/bikes/
├── domain/
│   ├── entities/
│   │   ├── bike.dart                          # ✅ Already exists
│   │   └── rent.dart                          # 🆕 Rent entity
│   └── repositories/
│       └── rents_repository.dart              # 🆕 Repository interface
├── data/
│   ├── dtos/
│   │   └── rent_dto.dart                      # 🆕 JSON serializable DTO
│   ├── datasources/
│   │   └── rents_firestore_datasource.dart    # 🆕 Firestore operations
│   ├── repositories/
│   │   └── rents_repository_impl.dart         # 🆕 Repository implementation
│   └── services/
│       ├── location_service.dart              # 🆕 Geolocation + geocoding
│       └── user_profile_service.dart          # 🆕 Local storage for contact info
└── presentation/
    ├── viewmodel/
    │   ├── notifiers/
    │   │   ├── rent_form_provider.dart        # 🆕 Form state management
    │   │   └── rent_submit_provider.dart      # 🆕 Submit AsyncNotifier
    │   └── states/
    │       └── rent_form_state.dart           # 🆕 Freezed form state
    ├── screens/
    │   └── bike_renting_form_screen.dart      # 🆕 Main checkout screen
    └── widgets/
        ├── mobile/
        │   └── rent_form_content_mobile.dart  # 🆕 Mobile scrollable layout
        ├── web/
        │   └── rent_form_content_web.dart     # 🆕 Web card layout
        └── shared/
            ├── bike_summary_card.dart         # 🆕 Bike info display
            ├── rental_period_fields.dart      # 🆕 From/To date pickers
            ├── pickup_location_field.dart     # 🆕 Location input + button
            ├── contact_fields.dart            # 🆕 Name, phone, email
            ├── payment_summary_card.dart      # 🆕 Price calculation display
            └── submit_button.dart             # 🆕 Send request button
```

## Domain Layer

### 1. Rent Entity (`rent.dart`)

**Purpose:** Represents a bike rental order

**Fields:**
- `id`: String (Firestore document ID)
- `bikeId`: String (reference to bike, not full bike object)
- `fromDate`: DateTime (rental start)
- `toDate`: DateTime (rental end)
- `pickupText`: String (location description)
- `locationLat`: double? (optional latitude)
- `locationLng`: double? (optional longitude)
- `contactName`: String
- `contactPhone`: String
- `contactEmail`: String
- `totalDays`: int (calculated days)
- `pricePerDay`: int (snapshot from bike)
- `totalAmount`: int (totalDays × pricePerDay)
- `createdAt`: DateTime (timestamp)

**Implementation:**
- Use Freezed for immutability
- Add `const Rent._()` private constructor
- Create mapper extension `RentMapper` for `toDto()`
- Define in domain/entities (business logic layer)

### 2. Rents Repository Interface (`rents_repository.dart`)

**Purpose:** Contract for rent operations

**Methods:**
- `Future<void> createRent(Rent rent)` - Persist rent to Firestore

## Data Layer

### 1. Rent DTO (`rent_dto.dart`)

**Purpose:** JSON serialization for Firestore

**Fields:** Same as Rent entity but all nullable

**Field mappings (kebab-case in Firestore):**
- `@JsonKey(name: 'bike-id')` for bikeId
- `@JsonKey(name: 'from-date')` for fromDate (store as Timestamp)
- `@JsonKey(name: 'to-date')` for toDate (store as Timestamp)
- `@JsonKey(name: 'pickup-text')` for pickupText
- `@JsonKey(name: 'location-lat')` for locationLat
- `@JsonKey(name: 'location-lng')` for locationLng
- `@JsonKey(name: 'contact-name')` for contactName
- `@JsonKey(name: 'contact-phone')` for contactPhone
- `@JsonKey(name: 'contact-email')` for contactEmail
- `@JsonKey(name: 'total-days')` for totalDays
- `@JsonKey(name: 'price-per-day')` for pricePerDay
- `@JsonKey(name: 'total-amount')` for totalAmount
- `@JsonKey(name: 'created-at')` for createdAt (store as Timestamp)

**Implementation:**
- Use json_serializable
- Add `fromJson` and `toJson` factory methods
- Create mapper extension `RentDtoMapper` for `toEntity()` with defaults
- Convert DateTime ↔ Timestamp in mapper

### 2. Rents Firestore Datasource (`rents_firestore_datasource.dart`)

**Purpose:** Direct Firestore operations

**Method:** `createRent(RentDto rentDto)`
- Access `rents` collection
- Generate new document ID
- Convert DTO to JSON with Timestamp conversion
- Write to Firestore
- Try-catch with rethrow pattern

**Provider:**
- @riverpod provider for datasource instance
- Watch firestoreProvider

### 3. Rents Repository Implementation (`rents_repository_impl.dart`)

**Purpose:** Implement repository interface

**Method:** `createRent(Rent rent)`
- Convert Rent entity to RentDto using mapper
- Call datasource createRent
- Try-catch with rethrow pattern

**Provider:**
- @riverpod provider for repository instance
- Watch rentsFirestoreDatasourceProvider

### 4. Location Service (`location_service.dart`)

**Purpose:** Handle geolocation and geocoding

**Methods:**
- `Future<bool> requestLocationPermission()` - Request permission using geolocator
- `Future<Position?> getCurrentPosition()` - Get current lat/lng
- `Future<String?> getAddressFromCoordinates(double lat, double lng)` - Reverse geocode using geocoding package

**Implementation:**
- Check permission status
- Request if needed
- Handle denied/permanent denial cases
- Return formatted address string from Placemark

**Provider:**
- @riverpod provider for service instance

### 5. User Profile Service (`user_profile_service.dart`)

**Purpose:** Store/retrieve contact info from local storage

**Methods:**
- `Future<String?> getName()` - Get stored name
- `Future<String?> getEmail()` - Get stored email
- `Future<void> saveName(String name)` - Persist name
- `Future<void> saveEmail(String email)` - Persist email

**Implementation:**
- Use SharedPreferences
- Keys: 'user_profile_name', 'user_profile_email'
- Store as strings

**Provider:**
- @riverpod provider that watches sharedPreferencesProvider
- Returns UserProfileService instance

## Presentation Layer

### 1. Rent Form State (`rent_form_state.dart`)

**Purpose:** Hold all form field values

**Fields:**
- `fromDate`: DateTime?
- `toDate`: DateTime?
- `pickupText`: String
- `locationLat`: double?
- `locationLng`: double?
- `contactName`: String
- `contactPhone`: String
- `contactEmail`: String

**Computed properties (getters):**
- `totalDays`: int - Calculate days between dates (min 1)
- `totalAmount`: int - Calculate totalDays × pricePerDay (needs pricePerDay parameter)
- `isValid`: bool - Check all required fields filled

**Implementation:**
- Use Freezed with const factory
- Add `const RentFormState._()` for custom getters
- Include copyWith for field updates

### 2. Rent Form Provider (`rent_form_provider.dart`)

**Purpose:** Manage form state

**Type:** Notifier (sync state)

**Initial state:**
- Load contact name/email from UserProfileService
- Empty dates and other fields

**Methods:**
- `setFromDate(DateTime date)` - Update from date
- `setToDate(DateTime date)` - Update to date
- `setPickupText(String text)` - Update pickup location
- `setLocation(double lat, double lng, String address)` - Set from geolocation
- `setContactName(String name)` - Update name (also save to local storage)
- `setContactPhone(String phone)` - Update phone
- `setContactEmail(String email)` - Update email (also save to local storage)
- `reset()` - Clear form

### 3. Rent Submit Provider (`rent_submit_provider.dart`)

**Purpose:** Handle form submission

**Type:** AsyncNotifier

**Method:** `submitRent(Bike bike, RentFormState formState)`
- Validate form state
- Calculate totalDays and totalAmount
- Build Rent entity from bike + formState
- Call rentsRepository.createRent()
- Return AsyncValue (loading/error/success)

**State management:**
- Use AsyncValue.guard() for automatic error handling
- Set loading state during submit
- Return success/error AsyncValue

### 4. Main Screen (`bike_renting_form_screen.dart`)

**Purpose:** Container screen for checkout

**Constructor:**
- Required parameter: `Bike bike` (from navigation)

**Build structure:**
- Scaffold with AppBar (mobile) or HeaderWeb (web)
- AppBar title: "I'm interested to rent"
- Back button
- Background: colorScheme.onPrimary
- Body: Conditional mobile/web content widget

**Listen to submit provider:**
- Use ref.listen on rentSubmitProvider
- On success: Show QuickAlert success → navigate back
- On error: Show QuickAlert error → keep form intact

**Responsive:**
- kIsWeb ? Web layout : Mobile layout

### 5. Mobile Layout (`rent_form_content_mobile.dart`)

**Structure:**
- SingleChildScrollView
- Column with all sections stacked:
  1. BikeSummaryCard
  2. RentalPeriodFields
  3. PickupLocationField
  4. ContactFields
  5. PaymentSummaryCard
  6. SubmitButton

**Padding:** 16px around content
**Spacing:** 20px between sections

### 6. Web Layout (`rent_form_content_web.dart`)

**Structure:**
- Center with ConstrainedBox (maxWidth: 900px)
- Padding: 32px
- Column layout:
  1. BikeSummaryCard (full width)
  2. Row with two columns:
     - Left: Form fields (RentalPeriod, Pickup, Contact)
     - Right: PaymentSummaryCard (sticky summary)
  3. SubmitButton (centered, max-width 400px)

**Alternative layout:** Stack form and summary vertically if preferred

### 7. Shared Widget: Bike Summary Card (`bike_summary_card.dart`)

**Purpose:** Display bike context (read-only)

**Content:**
- Horizontal layout (image + info)
- Image: 80×80px (mobile), 100×100px (web)
- Info column:
  - Bike model (titleLarge/headlineSmall)
  - Subtitle from model pattern ("Electric Scooter", etc.)
  - Range: "X km"
  - Price: "from Rp. XK / day"

**Styling:**
- Card with elevation
- Theme colors only
- Responsive text sizing

### 8. Shared Widget: Rental Period Fields (`rental_period_fields.dart`)

**Purpose:** From/To date pickers

**Layout:**
- Section title: "Rental Period"
- Two fields in column:
  - From Date (with calendar icon)
  - To Date (with calendar icon)

**Behavior:**
- Tap opens date picker
- To date must be >= From date (validation)
- Display formatted date (e.g., "Jan 15, 2025")
- Required field indicator

**State management:**
- Watch rentFormProvider
- Call provider methods on change

### 9. Shared Widget: Pickup Location Field (`pickup_location_field.dart`)

**Purpose:** Location input with geolocation

**Layout:**
- Section title: "Pickup Location"
- TextField for manual entry
- Button: "Use my location" with location icon

**Behavior:**
- TextField: Free text input
- Button press:
  1. Call locationService.requestLocationPermission()
  2. If granted: locationService.getCurrentPosition()
  3. If position: locationService.getAddressFromCoordinates()
  4. Prefill text field with address
  5. Store lat/lng in form state
  6. Show loading during operation
  7. Show error snackbar if fails

**State management:**
- Watch rentFormProvider
- Update pickup text and coordinates

### 10. Shared Widget: Contact Fields (`contact_fields.dart`)

**Purpose:** Name, phone, email inputs

**Layout:**
- Section title: "Contact Information"
- Three TextFields:
  - Name (prefilled from local storage)
  - Phone (required, with phone keyboard)
  - Email (prefilled from local storage, email keyboard)

**Behavior:**
- Name/email changes save to UserProfileService
- Basic validation (non-empty, email format)
- Required indicators

**State management:**
- Watch rentFormProvider
- Update on change

### 11. Shared Widget: Payment Summary Card (`payment_summary_card.dart`)

**Purpose:** Show price calculation

**Layout:**
- Card with slight elevation
- Section title: "Payment Summary"
- Line item: "Rp. X × Y days"
- Divider
- Total: "Rp. Z" (larger, bold, highlighted color)

**Calculation:**
- Watch rentFormProvider for dates
- Calculate totalDays from date difference
- Display: `formatPriceToRupiahK(bike.pricePerDay) × totalDays days`
- Total: `formatPriceToRupiahK(totalAmount)`
- Show "---" if dates not selected

**Responsive:**
- Larger text on web
- Prominent total display

### 12. Shared Widget: Submit Button (`submit_button.dart`)

**Purpose:** Send request button

**Label:** "Send request"

**Behavior:**
- Disabled if form invalid or loading
- On press: Call rentSubmitProvider.submitRent(bike, formState)
- Show loading indicator when submitting

**Styling:**
- FilledButton with primary color
- Full width on mobile
- Responsive padding (20px web, 16px mobile)
- Responsive text size

**State management:**
- Watch rentFormProvider for validation
- Watch rentSubmitProvider for loading state

## Routing Updates

### Update `routing.dart`

**Current placeholder route:** `/bikes/:bikeId/interest`

**Update to:**
- Import BikeRentingFormScreen
- Builder receives bikeId from path parameter
- Fetch bike from bikeDetailProvider or pass via extra
- Render BikeRentingFormScreen(bike: bike)

**Navigation from detail:**
- BikeCTAButton already navigates to this route with extra data
- Extract bike from extra in route builder
- Pass bike instance to screen constructor

## Implementation Steps

### Phase 1: Dependencies
1. Add packages: quickalert, geolocator, geocoding, shared_preferences
2. Run `flutter pub get`
3. Configure platform permissions:
   - iOS: Add location usage descriptions in Info.plist
   - Android: Add location permissions in AndroidManifest.xml

### Phase 2: Domain Layer
1. Create Rent entity with Freezed
2. Create RentsRepository interface

### Phase 3: Data Layer
1. Create RentDto with json_serializable
2. Create RentsFirestoreDatasource
3. Create RentsRepositoryImpl
4. Create LocationService
5. Create UserProfileService

### Phase 4: Presentation State
1. Create RentFormState with Freezed
2. Create RentFormProvider (Notifier)
3. Create RentSubmitProvider (AsyncNotifier)

### Phase 5: Shared Widgets (Bottom-Up)
1. Create BikeSummaryCard
2. Create RentalPeriodFields
3. Create PickupLocationField
4. Create ContactFields
5. Create PaymentSummaryCard
6. Create SubmitButton

### Phase 6: Layout Widgets
1. Create RentFormContentMobile
2. Create RentFormContentWeb

### Phase 7: Main Screen
1. Create BikeRentingFormScreen
2. Wire up providers and layouts
3. Add QuickAlert success/error handlers

### Phase 8: Routing
1. Update routing.dart to pass bike to screen
2. Test navigation from bike detail

### Phase 9: Code Generation & Testing
1. Run build_runner to generate code
2. Test form validation
3. Test date picker constraints
4. Test geolocation flow
5. Test contact prefill
6. Test payment calculation
7. Test submission to Firestore
8. Test success/error alerts
9. Test responsive layouts

## Key Design Decisions

### Why Separate Form State and Submit Provider?
- **Form state** (Notifier): Manages UI field values, synchronous updates
- **Submit provider** (AsyncNotifier): Handles async submission, loading/error states
- Clear separation of concerns: form manipulation vs. data persistence

### Why Store Contact Info Locally?
- Better UX: User doesn't retype name/email each time
- Privacy: Contact stays on device, not in Firestore
- Simple: SharedPreferences sufficient for key-value storage

### Why Snapshot pricePerDay in Rent?
- Price may change in bike collection later
- Historical accuracy: Rent shows price at time of booking
- No need to re-fetch bike to calculate amount

### Why Not Duplicate Bike Info in Rent?
- Firestore best practice: Store reference (bikeId), not full object
- Reduces data duplication
- If bike details change, rent doesn't need updates
- To display bike in rent history: join using bikeId

### Why QuickAlert Instead of Custom Dialogs?
- Consistent, polished UI out of the box
- Less code, faster implementation
- Brief specifically requests QuickAlert
- Success/error patterns are standard

### Why Geolocation + Geocoding Combo?
- geolocator: Gets precise lat/lng coordinates
- geocoding: Converts coordinates to human-readable address
- User sees friendly address, app stores both text and coordinates
- Gives flexibility for map features later

### Why Calculate totalDays and totalAmount?
- Pre-computed values easier to query/display later
- No need to recalculate in rent history screens
- Ensures consistency (calculation logic in one place)
- Formula: `max(1, toDate.difference(fromDate).inDays + 1)`

## Date Calculation Logic

**Total days formula:**
- Inclusive calculation: Both from and to date count as rental days
- Example: Jan 1 to Jan 1 = 1 day (same day rental)
- Example: Jan 1 to Jan 3 = 3 days (1st, 2nd, 3rd)
- Formula: `toDate.difference(fromDate).inDays + 1`
- Minimum: 1 day (even if same date selected)

## Location Flow Details

**Permission request:**
1. Check current permission status
2. If denied: Request permission
3. If permanently denied: Show settings dialog
4. If granted: Proceed to get position

**Get position:**
1. Call geolocator getCurrentPosition()
2. Receive Position with lat/lng
3. Pass to geocoding

**Reverse geocode:**
1. Call placemarkFromCoordinates(lat, lng)
2. Receive list of Placemark objects
3. Extract: street, locality, subLocality, administrativeArea
4. Combine into readable string (e.g., "Jl. Sudirman, Jakarta")
5. Return formatted address

**Error handling:**
- Permission denied: Show snackbar, allow manual entry
- Location disabled: Show snackbar asking to enable
- Network error: Show snackbar, fallback to manual entry
- Never block user from proceeding (manual entry always available)

## QuickAlert Integration

**Success alert:**
- Type: QuickAlertType.success
- Title: "Request Sent!"
- Message: "We've received your rental request. We'll contact you soon."
- Button: "OK" or "Back to Bikes"
- On dismiss: Navigate back (pop) or to home

**Error alert:**
- Type: QuickAlertType.error
- Title: "Oops!"
- Message: User-friendly error (e.g., "Failed to send request. Please try again.")
- Button: "OK"
- On dismiss: Keep form intact for retry

## Validation Rules

**Required fields:**
- From date: Must be selected
- To date: Must be selected, >= from date
- Pickup text: Non-empty string
- Contact name: Non-empty string
- Contact phone: Non-empty string, basic phone format
- Contact email: Valid email format

**Optional fields:**
- Location lat/lng: Only if "Use my location" was used

**Form valid when:**
- All required fields filled
- To date >= from date
- Email has valid format
- Phone is non-empty

## Firestore Structure

**Collection:** `rents`

**Document ID:** Auto-generated by Firestore

**Document fields:**
```
{
  "id": "auto-generated-id",
  "bike-id": "bike123",
  "from-date": Timestamp,
  "to-date": Timestamp,
  "pickup-text": "Jl. Sudirman, Jakarta",
  "location-lat": -6.208763,
  "location-lng": 106.845599,
  "contact-name": "Ahmad Mukhlis",
  "contact-phone": "+628123456789",
  "contact-email": "ahmad@example.com",
  "total-days": 3,
  "price-per-day": 50000,
  "total-amount": 150000,
  "created-at": Timestamp
}
```

## Color & Responsive Guidelines

**Reference:** AGENTS.md conventions

**Colors:**
- All theme colors from colorScheme
- No hardcoded Colors.white, Colors.black, etc.
- Use semantic tokens (primary, secondary, error, etc.)

**Text sizing:**
- kIsWeb ? larger : smaller
- Section titles: kIsWeb ? headlineSmall : titleLarge
- Body text: kIsWeb ? bodyLarge : bodyMedium
- Button text: kIsWeb ? headlineSmall : bodyLarge

**Spacing:**
- Mobile: 16px padding, 20px section spacing
- Web: 32px padding, 24-32px section spacing

## Error Handling

**Data layer:**
- Try-catch with rethrow in datasource and repository
- Let errors bubble to presentation layer

**Presentation layer:**
- Use AsyncValue.guard() in submit provider
- Show QuickAlert error with user-friendly messages
- Map technical errors to readable text
- Never expose raw Firebase errors to user

## Platform Permissions

### iOS (Info.plist)
Add location usage descriptions:
- NSLocationWhenInUseUsageDescription
- NSLocationAlwaysUsageDescription

### Android (AndroidManifest.xml)
Add location permissions:
- ACCESS_FINE_LOCATION
- ACCESS_COARSE_LOCATION

## Notes

- No hardcoded feature descriptions (follow new AGENTS.md rule)
- All displayed data comes from Bike entity or form input
- Use builder methods (`_buildX`) for widget organization
- Generate all providers/DTOs with build_runner
- SharedPreferences provider may already exist in project
- QuickAlert dialogs use Material theme automatically
- Geolocation requires physical device or emulator with location
- Test with various date ranges to verify calculation
- Consider loading state for "Use my location" button
