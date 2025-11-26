# Bike Renting Form / Checkout Brief

## Context
- This page is opened from **Bike Detail** when the user taps
  **“I’m interested to rent”**.
- Purpose: capture a simple intent to rent a specific bike, show a
  **checkout-style payment summary**, and persist the request.
- The screen receives the **full `Bike` model** as navigation data
  (for convenience), including:
    - `id`, `model`, `photoUrl`, `rangeKm`, `isAvailable`,
      `pricePerDay`, `pickupAreas`, etc.
- User fills rental period, pickup location, and contact details.
- The app calculates total payment and stores it together with the
  submission in Firestore using a dedicated **`Rent`** model.

## Scope
- Implement `BikeRentingFormScreen` for mobile + web:
    - mobile: full-screen, scrollable checkout layout,
    - web: centered card layout (form + summary stacked or side-by-side).
- Navigation:
    - From `BikeDetailScreen(bike)` → `BikeRentingFormScreen(bike)`.
- Domain/data:
    - Create an encapsulating class `Rent` (entity/DTO) that represents
      a single rent order.
    - Persist `Rent` documents into Firestore collection **`rents`**.
- On submit:
    - validate form,
    - calculate total payment,
    - build a `Rent` instance and write it to Firestore (`rents`).
- Use **QuickAlert** for success and error dialogs.
- Show a clear success state and return user to a sensible place
  (back to Detail or Home).

## Requirements

### Header & Context
- Header:
    - back button,
    - title: `I'm interested to rent`.
- Bike summary (read-only, from `Bike` model):
    - bike photo (`photoUrl`),
    - model name,
    - simple subtitle (e.g. `Electric Scooter`),
    - range and starting price (e.g. `from Rp <pricePerDay> / day`).

### Form Fields (user input)
- **From date**
    - Date picker, required.
- **To date**
    - Date picker, required.
    - Must be >= From date.
- **Pickup area / point**
    - Text field (user can always type location manually).
    - Optional dropdown/chips for common pickup areas.
    - Required.
    - Provide a secondary action:
        - button `Use my location` that:
            - requests location permission,
            - on grant, uses geolocation to fetch `lat/lng`,
            - reverse-geocodes to a human-readable address,
            - prefills the pickup text field with that address
              (user can still edit).
- **Contact**
    - **Name**
        - Prefilled from user profile persisted in local DB
          (e.g. shared preferences / Hive) **if available**.
        - If no stored value, field is empty and user can type their name.
        - Recommended to treat as required for a real request.
    - **Phone**
        - Text field, **required**.
        - Basic validation (non-empty, simple phone format).
    - **Email**
        - Autofilled from user profile persisted in local DB
          (same source as name).
        - Shown as a text field or read-only field with initial value from
          local storage; user may edit/confirm as needed.

### Price Calculation & Summary
- Based on **fromDate** and **toDate**:
    - compute total rental days (minimum 1 day),
    - compute **total payment**.
- Simple rule for this assignment:
    - `totalDays = max(1, differenceInDaysInclusive(fromDate, toDate))`
    - `totalAmount = totalDays * bike.pricePerDay`
- Show a **Payment Summary** section:
    - line item: `Rp <pricePerDay> x <totalDays> days`,
    - total: `Rp <totalAmount>` (highlight).
- Total payment must be included in the `Rent` payload and stored in
  the `rents` collection.

### Rent Model & Persistence
- Create a `Rent` class (and `RentDto` if following the same pattern
  as other features) that encapsulates the rent order:
    - `id` (Firestore doc id),
    - `bikeId` (reference to `bikes/<id>`),
    - `fromDate`,
    - `toDate`,
    - `pickupText`,
    - `locationLat` / `locationLng` (optional),
    - `contactName`,
    - `contactPhone`,
    - `contactEmail`,
    - `totalDays`,
    - `pricePerDay`,
    - `totalAmount`,
    - `createdAt`.
- Firestore:
    - collection: **`rents`**,
    - each document is one `Rent` order.

### Submit Behaviour & Alerts
- Primary button:
    - label: `Send request`,
    - disabled while loading or when form invalid.
- On submit:
    - build a `Rent` instance from:
        - navigation `Bike` data,
        - validated form values,
        - derived `totalDays` and `totalAmount`,
    - persist it as a document in the `rents` collection.
- Use [`quickalert`](https://pub.dev/packages/quickalert) for dialogs:
    - on success:
        - show a success QuickAlert (`QuickAlertType.success`)
          with a short confirmation message,
        - then navigate back (pop) or provide a `Back to bikes` action.
    - on error:
        - show an error QuickAlert (`QuickAlertType.error`) with a short,
          user-friendly message,
        - keep form values and summary intact so user can retry.

## Clues
- For location:
    - Use [`geolocator`](https://pub.dev/packages/geolocator)
      to request permission and fetch current `Position` (`lat/lng`).
    - Use [`geocoding`](https://pub.dev/packages/geocoding)
      to reverse-geocode coordinates into a human-readable address
      (street / area / city) and prefill the pickup text field.
- For contact prefill:
    - Store basic user profile (name, email, maybe phone) in local DB
      (e.g. `shared_preferences`, `Hive`), then read those values on
      this screen.
- Use an `AsyncNotifier` (or similar Riverpod 3 pattern) to manage
  submit state:
    - idle → loading → success/error, exposed as `AsyncValue`.
- Clearly separate:
    - raw `DateTime` values,
    - derived `totalDays` and `totalAmount`.
- `Rent` should encapsulate everything needed to understand a booking
  later, without needing to re-derive values in the UI.

## Keep in Mind
- The **full `Bike` model is only used locally** on this page for:
    - displaying context to the user,
    - deriving `pricePerDay` used in the calculation.
- In Firestore, **only the `bikeId` is stored** as the link to the
  bike; descriptive bike info (model name, photo, etc.) should
  not be duplicated in `rents` documents.
- Pricing logic should remain simple for this test (daily × days),
  but it’s useful to leave comments where plan-based pricing could be
  plugged in later.
- Add small comments around:
    - how geolocation and reverse geocoding fill the pickup field,
    - how QuickAlert is triggered on success/error,
    - what the `Rent` Firestore document structure looks like.
- Stay consistent with patterns used in **Bikes List** and
  **Bike Detail**:
    - clean separation of data/domain/presentation,
    - avoid over-engineering (DRY and YAGNI).