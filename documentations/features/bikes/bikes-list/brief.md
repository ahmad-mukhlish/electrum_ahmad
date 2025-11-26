# Bikes List Brief

## Context
- We will create the **Electrum Bikes list UI** and integrate it with **Firestore**.
- Create `Bike` entity (freezed):
    - `id` (String), `model` (String), `photoUrl` (String),
    - `rangeKm` (int), `isAvailable` (bool),
    - `pricePerDay` (int),
    - `pickupAreas` (List<String>, optional).
- Create `BikeDto` for Firestore mapping:
    - `id`, `model`, `photo-url`, `range-km`, `is-available`,
    - `price-per-day`, `pickup-areas`.
- Create **bike state** for UI:
    - wraps the entity and any UI-only flags if needed
- The card layout should follow the **car list references**:
    - clean image-focused card,
    - key specs and price under the photo.
- Data source: Firestore collection **`bikes`**.

## Scope
- Section lives on **Home screen** (mobile + web), **below Rental Packages**.
- Implement bike list UI:
    - mobile: vertical scroll list (single column),
    - web: responsive grid (multiple columns).
- Implement Firestore integration (read-only) for `bikes`.
- Use Firestore **offline cache** so bikes remain visible when offline.
- Should just render list under header web / appbar, do not add search and filter yet (separate brief)
- Create web and mobile component that being called in BikeScreen()
- In web the pages should be in grid, whilst in mobile in list

## Requirements
- User can see a list of bikes if:
    - online, or
    - offline but bikes are available in local cache.
- Each bike card shows at minimum:
    - model name,
    - main photo,
    - range (in km) and availability status,
    - starting price per day (e.g. “from Rp XX.XXX / day”).
- Tapping a bike opens the **Bike Detail** page (separate brief).
- If fetching bikes fails:
    - hide the bikes section,
    - show a snackbar: error loading bikes.

## Clues
- Reuse current **Promotions** data flow as reference for:
    - repository → notifier → UI wiring,
    - loading and error handling.
- For UI, refer to:
    - `references/bike-list-mobile-ref.jpeg` for mobile behaviour,
    - `references/bike-list-web-ref.jpeg` for web layout.

## Keep in Mind
- Keep code structure clean and consistent with existing layers.
- Add comments / documentation in critical sections:
    - Firestore mapping,
    - list → detail navigation.
- Keep changes as small and focused as possible.
- Follow DRY and YAGNI principles.