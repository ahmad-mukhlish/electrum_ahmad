# Maestro Home Screen Test Implementation Plan

## Overview

Add regression tests for the home screen (mobile and web) using Maestro. The home screen displays:
- Promotions carousel
- Rental plans list/grid

All tests will use Semantics labels for widget identification following the pattern established in auth tests.

---

## Phase 1: Add Semantics Labels to Flutter Widgets

### 1.1 Home Screen Root Container

**File:** `lib/features/home/presentation/widgets/mobile/home_content_mobile.dart`

**Location:** Wrap the `SingleChildScrollView` widget

**Semantics label:** `"Home screen"`

**Purpose:** Main container identifier for home screen on mobile

---

**File:** `lib/features/home/presentation/widgets/web/home_content_web.dart`

**Location:** Wrap the `SingleChildScrollView` widget

**Semantics label:** `"Home screen"`

**Purpose:** Main container identifier for home screen on web

---

### 1.2 Promotions Section

**File:** `lib/features/home/presentation/widgets/shared/promotions_carousel.dart`

**Location:** In the `data` case of `promotionsAsync.when()`, wrap the `CarouselSlider.builder` widget

**Semantics label:** `"Promo section"`

**Purpose:** Identify the promotions carousel section

**Notes:**
- Only add when promotions list is not empty
- Wrap the entire CarouselSlider widget

---

**File:** `lib/features/home/presentation/widgets/shared/promotion_card.dart`

**Location:** Wrap the `Card` widget in the `build` method

**Semantics label:** `"Promo card"`

**Purpose:** Identify individual promotion cards

**Notes:**
- Each promotion card will have the same label
- Maestro will use pattern matching to find any promo card

---

### 1.3 Plans Section

**File:** `lib/features/home/presentation/widgets/mobile/plans_section_mobile.dart`

**Location:** In the `data` case of `plansAsync.when()`, wrap the `Column` widget that contains the section title and plan cards

**Semantics label:** `"Plan section"`

**Purpose:** Identify the plans section on mobile

---

**File:** `lib/features/home/presentation/widgets/web/plans_section_web.dart`

**Location:** In the `data` case of `plansAsync.when()`, wrap the `Column` widget that contains period toggle and plan cards

**Semantics label:** `"Plan section"`

**Purpose:** Identify the plans section on web

---

**File:** `lib/features/home/presentation/widgets/shared/plan_card.dart`

**Location:** Wrap the `Card` widget in the `build` method

**Semantics label:** `"Plan card"`

**Purpose:** Identify individual plan cards

**Notes:**
- Each plan card will have the same label
- Maestro will use pattern matching to find any plan card

---

## Phase 2: Create Maestro Test Files

### 2.1 Update Root Orchestrator

**File:** `maestro/all-tests.yaml`

**Action:** Update to include home screen tests

**Changes:**
- Keep existing auth test flows
- Add `runFlow` for home screen setup
- Add `runFlow` for mobile home screen tests
- Add `runFlow` for web home screen tests

**Structure:**
```yaml
appId: com.electrum.app
---
# Master Test Orchestrator

# Auth Tests
- runFlow: common_tests/auth-setup.yaml
- runFlow: mobile/auth-mobile.yaml
- runFlow: web/auth-web.yaml

# Home Screen Tests
- runFlow: common_test/setup-home.yaml
- runFlow: mobile/screen_tests/home-screen-test.yaml
- runFlow: web/screen_tests/home-screen-test.yaml
```

**Note:** use existing `common_tests/` (plural).

---

### 2.2 Create Shared Setup Flow

**File:** `maestro/common_test/setup-home.yaml`

**Purpose:** Navigate to home screen from any state

**Test Flow:**
1. Launch app
2. Wait for animations
3. Check if user is logged in
   - If not logged in: perform login with seeded credentials
   - If logged in: verify home screen is visible
4. Assert home screen is displayed

**Key Assertions:**
- `".*Home screen.*"` is visible after setup

**Notes:**
- Reuse login credentials from auth tests: `ahmad.mukhlish.saputra@gmail.com` / `CobaCoba123`
- Handle both mobile and web cases
- Should work regardless of initial app state

---

### 2.3 Create Mobile Home Screen Tests

**File:** `maestro/mobile/screen_tests/home-screen-test.yaml`

**Directory:** Create `maestro/mobile/screen_tests/` folder

**Test Scenarios:**

#### Scenario 1: Home Loads
**Goal:** Verify home screen structure appears

**Steps:**
1. Run setup flow: `runFlow: ../../common_test/setup-home.yaml`
2. Assert home screen visible: `".*Home screen.*"`
3. Assert promo section visible: `".*Promo section.*"`
4. Assert plan section visible: `".*Plan section.*"`

#### Scenario 2: Promotions Visible
**Goal:** Ensure promo cards load

**Steps:**
1. Assert at least one promo card: `".*Promo card.*"`
2. Use `waitFor` if needed for async loading

#### Scenario 3: Promotions Swipeable
**Goal:** User can swipe carousel

**Steps:**
1. Swipe left on carousel
2. Assert promo card still visible after swipe
3. Optionally swipe right to verify bidirectional

#### Scenario 4: Plans Visible
**Goal:** Plans list appears and is scrollable

**Steps:**
1. Scroll until plan card visible using `scrollUntilVisible`
2. Assert at least one plan card: `".*Plan card.*"`

---

### 2.4 Create Web Home Screen Tests

**File:** `maestro/web/screen_tests/home-screen-test.yaml`

**Directory:** Create `maestro/web/screen_tests/` folder

**Test Scenarios:**

Same scenarios as mobile but adapted for web:

#### Scenario 1: Home Loads (Web)
**Steps:**
1. Run setup flow: `runFlow: ../../common_test/setup-home.yaml`
2. Assert home screen visible: `".*Home screen.*"`
3. Assert promo section visible: `".*Promo section.*"`
4. Assert plan section visible: `".*Plan section.*"`

#### Scenario 2: Promotions Visible (Web)
**Steps:**
1. Assert at least one promo card: `".*Promo card.*"`

#### Scenario 3: Promotions Navigable (Web)
**Steps:**
1. Swipe left on carousel (web supports swipe gestures)
2. Assert promo card still visible

#### Scenario 4: Plans Visible (Web)
**Steps:**
1. Scroll to plan section if needed
2. Assert at least one plan card: `".*Plan card.*"`

**Notes:**
- Web shows plans in a grid/row layout vs mobile's vertical list
- Both use the same semantic labels, so tests are very similar

---

### 2.5 Optional: Create Reusable Flows

**Files (Optional):**
- `maestro/common_test/swipe-promos.yaml` - Reusable promo swipe logic
- `maestro/common_test/check-plans.yaml` - Reusable plan verification logic

**Purpose:** Extract repeated test logic if tests become complex

**Recommendation:** Start without these, add only if needed during implementation

---


## Implementation Order

### Step 1: Add Semantics Labels (Flutter)
1. `home_content_mobile.dart` - Add "Home screen" label
2. `home_content_web.dart` - Add "Home screen" label
3. `promotions_carousel.dart` - Add "Promo section" label
4. `promotion_card.dart` - Add "Promo card" label
5. `plans_section_mobile.dart` - Add "Plan section" label
6. `plans_section_web.dart` - Add "Plan section" label
7. `plan_card.dart` - Add "Plan card" label

### Step 2: Create Maestro Files
1. Create `maestro/common_test/` directory (if not exists)
2. Create `maestro/common_test/setup-home.yaml`
3. Create `maestro/mobile/screen_tests/` directory
4. Create `maestro/mobile/screen_tests/home-screen-test.yaml`
5. Create `maestro/web/screen_tests/` directory
6. Create `maestro/web/screen_tests/home-screen-test.yaml`
7. Update `maestro/all-tests.yaml`

### Step 3: Test and Iterate
1. Run maestro studio to verify labels
2. Test mobile flow individually
3. Test web flow individually
4. Run full test suite
5. Fix any issues found

---

## File Structure After Implementation

```
maestro/
  all-tests.yaml                        # Updated with home tests
  common_tests/                         # Auth tests (existing)
    auth-setup.yaml
  common_test/                          # Home setup (new - note singular)
    setup-home.yaml
    swipe-promos.yaml                   # Optional
    check-plans.yaml                    # Optional
  mobile/
    auth-mobile.yaml                    # Existing
    screen_tests/                       # New directory
      home-screen-test.yaml
  web/
    auth-web.yaml                       # Existing
    screen_tests/                       # New directory
      home-screen-test.yaml
```

---

## Key Conventions to Follow

### Semantics Naming
- **MUST** follow: First word capitalized, second word lowercase
- **MUST** be max 2 words
- Examples: "Home screen", "Promo card", "Plan section"

### Maestro Test Patterns
- Use regex for all text matching: `".*Label text.*"`
- Use `runFlow` for shared logic
- Use `waitForAnimationToEnd` after navigation
- Use `assertVisible` for positive checks
- Use `assertNotVisible` for negative checks
- Use `scrollUntilVisible` for content below fold

### File Organization
- Keep mobile and web tests separate
- Share setup logic in `common_test/`
- Use relative paths from test file location: `../../common_test/setup-home.yaml`

---

## Notes

- **No code in plan:** This plan contains high-level descriptions only, actual implementation happens in Phase 1-3
- **Preserve existing:** Don't modify existing auth tests, only add home screen tests
- **Platform consistency:** Use identical semantic labels for mobile and web widgets
- **Data handling:** Tests should work with both empty and populated data (promotions/plans from Firestore)
- **Async loading:** Account for `AsyncValue` loading states in promotions and plans providers

---

## Success Criteria

- [ ] All 7 Flutter widgets have correct Semantics labels
- [ ] All 5 Maestro YAML files created and working
- [ ] Mobile home screen tests pass completely
- [ ] Web home screen tests pass completely
- [ ] Tests are maintainable and follow existing patterns
- [ ] No hardcoded delays, uses proper wait commands
