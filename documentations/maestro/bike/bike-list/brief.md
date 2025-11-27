# Maestro Bike Menu Test Brief

## Context

Add **Bike menu + search + filter** regression tests for **mobile and web** using Maestro.

Bike screen supports:
- Navigating from Home via **Bike menu**.
- Viewing bike list.
- Searching by model (e.g. `H1`).
- Showing an **empty state** when no results.
- Resetting filters.
- Filter behaviour is **different for mobile and web**.

Follow the established Maestro structure:

```text
maestro/
├── all-tests.yaml                   # Master test orchestrator (entry point)
├── common/                          # Reusable flows shared between platforms
│   ├── auth-setup.yaml             # Authentication setup flow (already exists)
│   ├── setup-home.yaml             # Home screen setup flow (already exists)
│   ├── bikes-setup.yaml            # NEW: enter bike screen from home
│   ├── bikes-assert-list.yaml      # NEW: assert bikes list visible
│   └── bikes-assert-empty.yaml     # NEW: assert empty state visible
├── mobile/
│   └── flows/                      # Mobile-specific test flows
│       ├── auth-flow-mobile.yaml   # Existing mobile auth tests
│       ├── home-flow-mobile.yaml   # Existing mobile home tests
│       └── bikes-flow-mobile.yaml  # NEW: mobile bike tests (this brief)
└── web/
    └── flows/                      # Web-specific test flows
        ├── auth-flow-web.yaml      # Existing web auth tests
        ├── home-flow-web.yaml      # Existing web home tests
        └── bikes-flow-web.yaml     # NEW: web bike tests (this brief)
```

`all-tests.yaml` will be updated to include both `bikes-flow-mobile.yaml` and `bikes-flow-web.yaml` via `runFlow`.

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

### Web filter labels (sidebar)

```dart
Semantics(label: "Filter available", child: availableOnlyCheckbox);
Semantics(label: "Filter premium", child: premiumPriceOption);
Semantics(label: "Filter deluxe", child: deluxePriceOption);
Semantics(label: "Filter long", child: longRangeOption);      // Range Km: Long Range
Semantics(label: "Filter reset", child: sidebarResetButton);  // bottom reset button
```

### Mobile filter labels (bottom sheet / dialog)

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

## Shared Flows (maestro/common)

### `bikes-setup.yaml`

Purpose: navigate into Bike screen from a clean state.

```yaml
appId: com.electrum.app
---
- runFlow: auth-setup.yaml      # if auth required, or skip if already in home
- runFlow: setup-home.yaml      # ensure at home screen
- tapOn:
    text: ".*Bike menu.*"
- assertVisible:
    text: ".*Bike screen.*"
- assertVisible:
    text: ".*Bike section.*"
```

### `bikes-assert-list.yaml` (reusable)

Check that **the list is showing bikes**:

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

These steps apply conceptually to both mobile and web; each platform flow will implement them with the same semantics.

### Core search flow

1. **Click Bike menu & assert list**

   In platform flow:

   ```yaml
   - runFlow: ../../common/bikes-setup.yaml
   - runFlow: ../../common/bikes-assert-list.yaml
   ```

2. **Scroll Bikes (if any)**

   ```yaml
   - scrollUntilVisible:
       element:
         text: ".*Bike card.*"
   ```

3. **Type `H1` in search and confirm results**

   ```yaml
   - tapOn:
       text: ".*Bike search.*"
   - inputText: "H1"
   - pressKey: Enter
   - assertVisible:
       text: ".*Bike card.*"
   ```

4. **Type nonsense `testesttestste` and see empty state**

   ```yaml
   - tapOn:
       text: ".*Bike search.*"
   - eraseText
   - inputText: "testesttestste"
   - pressKey: Enter
   - runFlow: ../../common/bikes-assert-empty.yaml
   ```

5. **Click Reset Filter on empty state and confirm list**

   ```yaml
   - tapOn:
       text: ".*Empty reset.*"
   - runFlow: ../../common/bikes-assert-list.yaml
   ```

---

## Scenarios – Web Filter Behaviour

File: `maestro/web/flows/bikes-flow-web.yaml`

### Entry

At the top of the flow:

```yaml
appId: com.electrum.app
---
- runFlow: ../../common/bikes-setup.yaml
- runFlow: ../../common/bikes-assert-list.yaml
```

### 1. Web search flow

Include the shared search flow described above.

### 2. Web filter: Available Only

```yaml
- tapOn:
    text: ".*Filter available.*"
- runFlow: ../../common/bikes-assert-list.yaml
```

### 3. Web filter: Price Range – Premium

```yaml
- tapOn:
    text: ".*Filter premium.*"
- runFlow: ../../common/bikes-assert-list.yaml
```

### 4. Web filter: Price Range – Deluxe → empty

```yaml
- tapOn:
    text: ".*Filter deluxe.*"
- runFlow: ../../common/bikes-assert-empty.yaml
```

### 5. Web filter: Reset button at bottom

```yaml
- tapOn:
    text: ".*Filter reset.*"
- runFlow: ../../common/bikes-assert-list.yaml
```

### 6. Web filter: Range Km – Long Range

```yaml
- tapOn:
    text: ".*Filter long.*"
- runFlow: ../../common/bikes-assert-list.yaml
```

---

## Scenarios – Mobile Filter Behaviour

File: `maestro/mobile/flows/bikes-flow-mobile.yaml`

### Entry

```yaml
appId: com.electrum.app
---
- runFlow: ../../common/bikes-setup.yaml
- runFlow: ../../common/bikes-assert-list.yaml
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
   - runFlow: ../../common/bikes-assert-list.yaml
   ```

5. Assert Available Only chip visible

   ```yaml
   - assertVisible:
       text: ".*Chip available.*"
   ```

### B. Mobile filter: Price Range – Premium

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
   - runFlow: ../../common/bikes-assert-list.yaml
   ```

5. Price Premium chip visible

   ```yaml
   - assertVisible:
       text: ".*Chip premium.*"
   ```

### C. Mobile filter: Price Range – Deluxe → empty, then clear chip

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
   - runFlow: ../../common/bikes-assert-empty.yaml
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
   - runFlow: ../../common/bikes-assert-list.yaml
   ```

*(Adjust chip-close behaviour if you expose a separate close icon via semantics.)*

### D. Mobile filter: Range (km) – Long Range

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
   - runFlow: ../../common/bikes-assert-list.yaml
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
   - runFlow: ../../common/bikes-assert-list.yaml
   ```

---

## Orchestration – all-tests.yaml

Update `maestro/all-tests.yaml` to include the new flows:

```yaml
appId: com.electrum.app
---
# Auth flows
- runFlow: common/auth-setup.yaml

# Home flows
- runFlow: mobile/flows/home-flow-mobile.yaml
- runFlow: web/flows/home-flow-web.yaml

# Bike flows
- runFlow: mobile/flows/bikes-flow-mobile.yaml
- runFlow: web/flows/bikes-flow-web.yaml
```

---

## Keep in Mind

- Reuse `bikes-assert-list.yaml` and `bikes-assert-empty.yaml` for all assertions.
- Keep bike tests focused on:
  - Navigation to bike screen
  - Search behaviour
  - Filter behaviour (web + mobile)
- Do not mix **bike detail** or **rent form** flows here.
- Always use regex with semantic labels in Maestro:
  - `".*Bike card.*"`, `".*Bike empty.*"`, `".*Filter button.*"`, etc.
