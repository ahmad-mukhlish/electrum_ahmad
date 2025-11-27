# Bikes Filter & Search Brief

## Context
- This feature extends the existing **Bikes List** on the Bike screen.
- Goal: help users quickly find the right Electrum bike by:
    - free-text search (by model name),
    - simple filters (availability, price range, range in km).
- Filtering and search should work **on top of** the already loaded bikes data,
  not by issuing new Firestore queries each time.
- Think in terms of:
    - one source of truth for the full bikes list,
    - a small piece of **filter state**,
    - and a **derived, filtered view** of the list consumed by the UI.

## Scope
- Extend the **Home → Electrum Bikes** section with search & filters:

### Mobile
- Top row above the bikes list:
    - Search bar (search by model name),
    - `Filter` button / icon.
- Tapping `Filter` opens a **modal filter dialog / bottom sheet**:
    - contains all filter controls (availability, price range bucket, range bucket),
    - has `Reset` and `Apply` actions.
- Filters are only applied when the user taps **Apply**.
- Optionally show an indicator on the button, e.g. `Filter (2)` when filters are active.

### Web
- Keep the bikes grid as the main content (center).
- Add a **right-side filter panel** (left side is reserved for main nav), inspired by the car-rental reference:
    - panel contains search field and all filters stacked vertically,
    - grid of bikes updates as filters/search change.

- Filtering operates only on bikes already loaded in memory.
- No need to persist filter state across app restarts.

## Requirements

### Search
- Text input labeled something like `Search your next ride`.
- Behaviour:
    - filters bikes by model name (case-insensitive substring),
    - updates the displayed list reactively (on submit or as user types, up to you).
- If search returns no result:
    - show an empty state message (e.g. “No bikes match your search”).

### Filters

Start pragmatic and focused:

- **Availability**
    - Toggle / checkbox: `Available only`.
    - When active, show only bikes with `isAvailable == true`.

- **Price range (per day)**
    - Use simple buckets derived from `pricePerDay`, for example:
        - `Budget` (≤ 30k),
        - `Premium` (30k–60k),
        - `Deluxe` (> 60k).
    - Buckets are calculated in the app; no need to store them in Firestore.

- **Range (km)**
    - Buckets derived from `rangeKm`, for example:
        - `Short range` (< 80 km),
        - `Medium range` (80–110 km),
        - `Long range` (> 110 km).

- Filters should be **combinable** with search:
    - final list = bikes that satisfy **search term AND all active filters**.
- Provide a clear `Reset filters` / `Clear all` action (inside dialog on mobile, near panel header on web).

### State & Data Flow
- Keep the existing bikes-loading flow as the **single source of truth** for the full list
  (including loading/error states and Firestore caching).
- Introduce a small **filter state** holding:
    - search text,
    - availability flag,
    - selected price bucket,
    - selected range bucket.
- UI should not manually filter arrays in many places:
    - expose a **single filtered bikes view** derived from
      the full list + filter state, and make the list/grid consume that.
- Filtering is **purely in-memory**:
    - changing filters must **not** trigger new Firestore reads.

### Layout

**Web**
- Right sidebar for filters:
    - search field at the top,
    - then Availability, Price buckets, Range buckets,
    - optionally a small label like “Showing X bikes”.
- Main content:
    - bikes grid (2–3 columns depending on width),
    - cards reuse the existing bikes-list visual design.

**Mobile**
- Section header row:
    - search bar as primary element,
    - `Filter` icon/button to open modal filter dialog / bottom sheet.
- Filter dialog:
    - grouped sections (Availability, Price, Range),
    - `Reset` and `Apply` buttons at the bottom.
- Active filters should be visible:
    - e.g. `Filter (2)` or a subtle “X filters applied” helper text.

## Clues
- Reuse the existing **Bikes List / Promotions** data flow as reference for:
    - repository → notifier → UI wiring,
    - loading and error handling.
- Centralise filter logic:
    - one place that takes `allBikes` + `filterState` and returns `filteredBikes`.
    - makes adding a new filter later a single-spot change.

## Keep in Mind
- This is a take-home with limited time:
    - prioritise a **clean, believable** experience over advanced filtering.
- Focus on:
    - clear separation between data loading, filter state, and UI,
    - small reusable widgets for search field and filter dialog/panel.
- Empty states should distinguish:
    - “still loading bikes” vs
    - “no bikes match current filters/search”.
- Keep naming and structure consistent with the rest of the feature folders.