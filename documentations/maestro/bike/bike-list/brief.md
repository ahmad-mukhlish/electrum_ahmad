# Maestro Bike Menu Test Brief

## Context

Add **Bike menu + search + filter** regression tests for **mobile and web** using Maestro.

Bike screen supports:
- Navigating from Home via **Bike menu**.
- Viewing bike list.
- Searching by model (e.g. `"H1"`).
- Showing an **empty state** when no results.
- Resetting filters.
- Filter behaviour is **different for mobile and web**.

Preserve folder structure:

```text
maestro/
  all-tests.yaml
  mobile/
    screen_tests/
      bikes-screen-test.yaml
  web/
    screen_tests/
      bikes-screen-test.yaml
  common_test/
    bikes-setup.yaml
    bikes-assert-list.yaml
    bikes-assert-empty.yaml
```

`all-tests.yaml` will `runFlow` both mobile and web bike tests.

---

## Semantics (CRITICAL, max 2 words)

Use `Semantics` in Flutter with **2-word labels**, first word capitalized, second lowercase.

### Shared labels

```dart
// Navigation
Semantics(label: "Bike menu", child: bikeNavItem);

// Screen
Semantics(label: "Bike screen", child: bikeScreenRoot);
Semantics(label: "Bike section", child: bikesListSection);

// Cards + list
Semantics(label: "Bike card", child: singleBikeCard);

// Search
Semantics(label: "Bike search", child: searchTextField);

// Empty state
Semantics(label: "Bike empty", child: emptyStateWidget);

// Reset from empty state
Semantics(label: "Empty reset", child: emptyStateResetButton);
```

### Web filter labels

Right sidebar filters:

```dart
Semantics(label: "Filter available", child: availableOnlyCheckbox);
Semantics(label: "Filter premium", child: premiumPriceOption);
Semantics(label: "Filter deluxe", child: deluxePriceOption);
Semantics(label: "Filter long", child: longRangeOption);      // Range Km: Long Range
Semantics(label: "Filter reset", child: sidebarResetButton);  // bottom reset button
```

### Mobile filter labels

Bottom sheet / dialog filters:

```dart
// Open filter
Semantics(label: "Filter button", child: filterOpenButton);

// Filter options
Semantics(label: "Filter available", child: availableOnlyCheckbox);
Semantics(label: "Filter premium", child: premiumPriceOption);
Semantics(label: "Filter deluxe", child: deluxePriceOption);
Semantics(label: "Filter long", child: longRangeOption);

// Actions
Semantics(label: "Filter apply", child: applyButton);
Semantics(label: "Filter reset", child: resetButton);

// Chips (applied filters)
Semantics(label: "Chip available", child: availableChip);
Semantics(label: "Chip premium", child: premiumChip);
Semantics(label: "Chip range", child: longRangeChip);
```

In Maestro, always assert/tap via regex:

```yaml
- assertVisible:
    text: ".*Bike card.*"
- tapOn:
    text: ".*Filter button.*"
```

---

## Shared Flows (common_test)

### `bikes-setup.yaml`

Purpose: navigate into Bike screen from a clean state.

Steps (conceptual):

```yaml
appId: com.electrum.app
---
- tapOn:
    text: ".*Bike menu.*"
- assertVisible:
    text: ".*Bike screen.*"
- assertVisible:
    text: ".*Bike section.*"
```

### `bikes-assert-list.yaml` (reusable)

Check that **the list is showing bikes** (used many times):

```yaml
appId: com.electrum.app
---
- assertVisible:
    text: ".*Bike section.*"
- assertVisible:
    text: ".*Bike card.*"
```

### `bikes-assert-empty.yaml` (reusable)

Check that **no bikes** and **empty state** visible:

```yaml
appId: com.electrum.app
---
- assertVisible:
    text: ".*Bike empty.*"
- assertNotVisible:
    text: ".*Bike card.*"
```

---

## Scenarios – Shared Search Behaviour

These steps apply conceptually to both mobile and web; each platform file will implement them with the same semantics.

1. **Click Bike menu**
   - `runFlow: ../common_test/bikes-setup.yaml` (or from root in `all-tests.yaml`)

2. **Assert Bikes is there**
   - `runFlow: ../common_test/bikes-assert-list.yaml`

3. **Scroll Bikes (if any)**

```yaml
- scrollUntilVisible:
    element:
      text: ".*Bike card.*"
```

4. **Type "H1" in search**

```yaml
- tapOn:
    text: ".*Bike search.*"
- inputText: "H1"
- pressKey: Enter
- assertVisible:
    text: ".*Bike card.*"
```

5. **Type nonsense "testesttestste"**

```yaml
- tapOn:
    text: ".*Bike search.*"
- eraseText
- inputText: "testesttestste"
- pressKey: Enter
- runFlow: ../common_test/bikes-assert-empty.yaml
```

6. **Click Reset Filter on empty state**

```yaml
- tapOn:
    text: ".*Empty reset.*"
- runFlow: ../common_test/bikes-assert-list.yaml
```

---

## Scenarios – Web Filter Behaviour

File: `maestro/web/screen_tests/bikes-screen-test.yaml`

Assume this file first runs:

```yaml
- runFlow: ../../common_test/bikes-setup.yaml
- runFlow: ../../common_test/bikes-assert-list.yaml
```

### 1. Web search flow

Implement the shared search steps above (bike menu, search `"H1"`, search `"testesttestste"`, empty reset).

### 2. Web filter: Available Only

```yaml
- tapOn:
    text: ".*Filter available.*"
- runFlow: ../../common_test/bikes-assert-list.yaml
```

### 3. Web filter: Price Range Premium

```yaml
- tapOn:
    text: ".*Filter premium.*"
- runFlow: ../../common_test/bikes-assert-list.yaml
```

### 4. Web filter: Price Range Deluxe → empty

```yaml
- tapOn:
    text: ".*Filter deluxe.*"
- runFlow: ../../common_test/bikes-assert-empty.yaml
```

### 5. Web filter: Reset in sidebar

```yaml
- tapOn:
    text: ".*Filter reset.*"
- runFlow: ../../common_test/bikes-assert-list.yaml
```

### 6. Web filter: Range Km – Long Range

```yaml
- tapOn:
    text: ".*Filter long.*"
- runFlow: ../../common_test/bikes-assert-list.yaml
```

---

## Scenarios – Mobile Filter Behaviour

File: `maestro/mobile/screen_tests/bikes-screen-test.yaml`

Assume this file first runs:

```yaml
- runFlow: ../../common_test/bikes-setup.yaml
- runFlow: ../../common_test/bikes-assert-list.yaml
```

### A. Mobile filter: Available Only

1. Click Filter

```yaml
- tapOn:
    text: ".*Filter button.*"
```

2. Click Available Only

```yaml
- tapOn:
    text: ".*Filter available.*"
```

3. Click Apply

```yaml
- tapOn:
    text: ".*Filter apply.*"
```

4. Assert Bikes is there

```yaml
- runFlow: ../../common_test/bikes-assert-list.yaml
```

5. Assert Available Only chip visible

```yaml
- assertVisible:
    text: ".*Chip available.*"
```

### B. Mobile filter: Price Range Premium

1. Click Filter

```yaml
- tapOn:
    text: ".*Filter button.*"
```

2. Click Price Range: Premium

```yaml
- tapOn:
    text: ".*Filter premium.*"
```

3. Click Apply

```yaml
- tapOn:
    text: ".*Filter apply.*"
```

4. Assert Bikes is there

```yaml
- runFlow: ../../common_test/bikes-assert-list.yaml
```

5. Price Premium chip visible

```yaml
- assertVisible:
    text: ".*Chip premium.*"
```

### C. Mobile filter: Price Range Deluxe → empty, then clear chip

1. Click Filter

```yaml
- tapOn:
    text: ".*Filter button.*"
```

2. Click Price Range: Deluxe

```yaml
- tapOn:
    text: ".*Filter deluxe.*"
```

3. Click Apply

```yaml
- tapOn:
    text: ".*Filter apply.*"
```

4. Confirm bikes not visible and empty visible

```yaml
- runFlow: ../../common_test/bikes-assert-empty.yaml
```

5. Premium chip visible (if still active)

```yaml
- assertVisible:
    text: ".*Chip premium.*"
```

6. Click close on Premium chip

```yaml
- tapOn:
    text: ".*Chip premium.*"
```

7. Assert Bikes is there

```yaml
- runFlow: ../../common_test/bikes-assert-list.yaml
```

*(Adjust exact chip-close interaction as implemented – could be a close icon inside the chip, still selectable via the same label.)*

### D. Mobile filter: Range (km) Long Range

1. Click Filter

```yaml
- tapOn:
    text: ".*Filter button.*"
```

2. Click Range (km) : Long Range

```yaml
- tapOn:
    text: ".*Filter long.*"
```

3. Click Apply

```yaml
- tapOn:
    text: ".*Filter apply.*"
```

4. Assert Bikes is there

```yaml
- runFlow: ../../common_test/bikes-assert-list.yaml
```

5. Range Long chip visible

```yaml
- assertVisible:
    text: ".*Chip range.*"
```

### E. Mobile filter: Reset

1. Click Filter

```yaml
- tapOn:
    text: ".*Filter button.*"
```

2. Click Reset

```yaml
- tapOn:
    text: ".*Filter reset.*"
```

3. Assert Bikes is there

```yaml
- runFlow: ../../common_test/bikes-assert-list.yaml
```

---

## Keep in Mind

- Reuse `bikes-assert-list.yaml` and `bikes-assert-empty.yaml` everywhere to avoid duplication.
- Do not mix **bike detail** or **rent form** flows here; this brief is for:
  - Navigation to bike menu
  - Search behaviour
  - Filter behaviour (web + mobile)
- Always use regex with semantic labels in Maestro:
  - `".*Bike card.*"`, `".*Bike empty.*"`, `".*Filter button.*"`, etc.
