# Rent History Brief

## Context
- Show a **read-only history list** of rent submissions created from the **Renting Form**.
- Screen placement:
    - Lives in the **Profile page**, directly **below user name / email** section.
    - Replace the existing lottie there (**remove the lottie widget and the lottie dependency from pubspec**).
- Data source: Firestore collection **`rents`** (already used by the renting flow).
- Use existing `Rent` encapsulating class as the domain model:
    - `id`, `bikeId`, `bikeModel`, `photoUrl?`,
    - `fromDate`, `toDate`,
    - `pickupArea`, `locationAddress`,
    - `contactName`, `contactPhone`, `contactEmail`,
    - `totalPrice`, `createdAt`, `status` (e.g. `"pending"`, `"confirmed"`).

### What belongs in **list** vs **detail**

**List (compact summary per rent):**
- bike **model** (main title),
- small **thumbnail** (`photoUrl`) on the left,
- **date range** (`fromDate – toDate`) + total days,
- **pickupArea** (short text),
- **totalPrice** (e.g. `Rp 320.000`),
- **status badge** (Pending / Confirmed / Completed).
> List should stay compact and scannable, no long texts or full address.

**Detail (full rent view):**
- all list info, plus:
    - full **locationAddress**,
    - **contactName**, **contactPhone**, **contactEmail**,
    - exact **fromDate / toDate** with time if available,
    - breakdown of price if already available (optional),
    - `createdAt` (“Requested on …”).
- Detail may be a full page **or** a bottom sheet; list passes the selected `Rent`.

---

## Scope
- Profile page:
    - show **“Rent History”** section under name/email, replacing the previous lottie block.
    - remove any lottie-specific code and dependency.
- Mobile:
    - vertical list of cards.
- Web:
    - same cards in a centered column with more padding (no complex grid).
- Firestore:
    - query `rents` **filtered by current user** (by `contactEmail` or `userId` if available),
    - ordered by `createdAt` descending.
- Two UI layers:
    1. **History list** (summary cards).
    2. **Rent detail view** (expanded info for a single rent).

## Requirements
- When profile opens:
    - show loading indicator while querying Firestore for this user’s rents,
    - then render rent history list (most recent first).
- Each list card shows at minimum:
    - model name,
    - thumbnail,
    - date range and number of days,
    - pickupArea (short),
    - totalPrice,
    - status badge.
- Tapping a card:
    - opens **Rent Detail** view (sheet or page) with:
        - bikeModel, photo, full date/time,
        - pickupArea + full locationAddress,
        - contactName, contactPhone, contactEmail,
        - totalPrice and any extra details available (e.g. plan or discounts),
        - status, createdAt (“Requested on…”).
- Empty state:
    - if user has **no rents**, show a simple illustration/icon + text  
      “No rentals yet. Your future trips will appear here.”
- Error state:
    - show a non-blocking error (snackbar / inline message),
    - keep screen visible with a retry button.

## Clues
- Reuse existing Firestore + Riverpod flow:
    - `RentRepository` / `RentDto` → `RentHistoryNotifier` → Profile UI.
- Prefer a **FutureProvider / AsyncNotifier** for the history list.
- Create a small **RentHistoryItemState**:
    - pre-formatted dates, total days, price string, status label/color.
- Use shared date/price formatting helpers to keep cards + detail consistent.
- For design, reuse:
    - card style from bike list (shadow, rounded corners),
    - typography from payment summary / form.

## Keep in Mind
- Only **read** from `rents`; writing still happens only from the renting form.
- Filter strictly to the **current user’s** rents (no global list).
- List view must stay compact:
    - avoid overloading cards with long text; push details to the detail view.
- Add comments for:
    - Firestore query (`where` + `orderBy`),
    - mapping `Rent` → `RentHistoryItemState`,
    - passing selected rent into detail.
- Keep implementation small and focused, aligned with other briefs
  (DRY, YAGNI, clean separation between data, domain, and presentation).