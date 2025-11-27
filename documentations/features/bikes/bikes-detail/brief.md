# Bike Detail Brief

## Context
- Build the **Bike Detail** screen that is opened when a user taps a bike
  card from the Home bikes list.
- Reuse the existing `Bike` entity / `BikeDto` and Firestore `bikes`
  collection (no new schema).
- Detail screen focuses on:
    - showing richer info for a single bike,
    - providing a clear CTA: **“I’m interested to rent”** that goes to a
      dedicated Interest Form page (separate brief).

## Scope
- Implement `BikeDetailScreen` for both mobile and web:
    - mobile: single-column, scrollable layout,
    - web: centered content with max-width container but same sections.
- Read bike data from Firestore via `bikeId` passed from the list.
- Handle loading and error states.
- Wire CTA button to navigate to `InterestFormScreen` with:
    - `bikeId` and `model` (and optionally `photoUrl`).

## Requirements
- When the screen is opened, user should see:
    - hero section with main photo (`photoUrl`) on a clean gradient/card
      background,
    - model name as primary title,
    - short line under title built from existing fields
      (e.g. “Electric Scooter” or “Urban commuter” – can be hardcoded
      per bike for now).
- Show a compact spec row, inspired by the tags in the list reference:
    - range: `rangeKm` in km,
    - availability badge from `isAvailable`,
    - starting price: `from Rp <pricePerDay> / day`.
- Below specs, show:
    - optional description / bullet list (can be static for the test),
    - list of `serviceCenterAreas` if available (chips or simple text).
- Primary CTA:
    - button label: `I'm interested to rent`,
    - disabled if `isAvailable == false`,
    - on press: navigate to Interest Form page with the selected bike data.
- Loading state:
    - progress indicator or simple skeleton while fetching.
- Error state:
    - error message with “Retry” and “Back” options.
- Back navigation:
    - top app bar / back button returns to bikes list.

## Clues
- Keep visual language consistent with bikes list cards:
    - large image, clear hierarchy.
- Data flow should mirror Promotions / Bikes list:
    - route param → provider (watch `Bike` by id) → detail UI.
- It is acceptable to reuse the same `Bike` provider used in the list,
  but scoped to a single `bikeId`.

## Keep in Mind
- Do not add search, filters, or multi-step booking here
  (they belong to other briefs).
- Keep layout simple and focused on one clear action
  (“I’m interested to rent”).
- Add comments for:
    - how `bikeId` is received from navigation,
    - how loading/error states are handled.
- Follow the same clean architecture and naming used in **Bikes List Brief**,
  and avoid unnecessary abstraction (DRY + YAGNI).