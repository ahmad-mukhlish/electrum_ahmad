# Maestro Home Screen Test Brief

## Context

Add **Home screen regression tests** for **mobile and web** using Maestro.

Home screen shows:
- Promotions carousel
- Rental plans list/grid

UI uses `Semantics` labels (max 2 words). Tests must assert by these labels with regex.

Expected folder structure (preserve this):

```text
maestro/
  all-tests.yaml
  mobile/
    screen_tests/
      home-screen-test.yaml
  web/
    screen_tests/
      home-screen-test.yaml
  common_test/
    setup-home.yaml
    swipe-promos.yaml      # optional
    check-plans.yaml      # optional
```

The single `all-tests.yaml` at root is the entry point and will `runFlow` both mobile and web home screen tests.

---

## Semantics Assumptions

These labels must exist in Flutter code for Maestro tests to work:

- Root
  - Home container: **`"Home screen"`**

- Promotions
  - Section wrapper: **`"Promo section"`**
  - Each card: **`"Promo card"`**
  - Optional controls:
    - Next: **`"Promo next"`**
    - Previous: **`"Promo prev"`**

- Plans
  - Section wrapper: **`"Plan section"`**
  - Each card: **`"Plan card"`**

Naming rule: first word capitalized, second lowercase, max 2 words.

---

## Files to Create

### Root Orchestration

- `maestro/all-tests.yaml`

Example:

```yaml
appId: com.electrum.app
---
# Shared setup + per-platform home tests
- runFlow: common_test/setup-home.yaml

# Mobile home screen tests
- runFlow: mobile/screen_tests/home-screen-test.yaml

# Web home screen tests
- runFlow: web/screen_tests/home-screen-test.yaml
```

### Shared Flows

In `maestro/common_test/`:

- `setup-home.yaml`  
  - Launch app (platform-agnostic entry).
  - Ensure user is logged in or navigate past auth if needed.
  - Navigate to Home screen.
- `swipe-promos.yaml` (optional reusable flow).
- `check-plans.yaml` (optional reusable flow).

---

## Test Scenarios – Mobile

File: `maestro/mobile/screen_tests/home-screen-test.yaml`

You may `runFlow` shared steps from `../common_test/` using relative paths from root if needed (or keep paths root-based as in `all-tests.yaml`).

### 1. Home Loads

Goal: Verify Home structure appears.

Steps:

1. (optional) Assume `setup-home.yaml` already run by `all-tests.yaml`, or call it:

   ```yaml
   - runFlow: ../../common_test/setup-home.yaml
   ```

2. Assertions:

   ```yaml
   - assertVisible:
       text: ".*Home screen.*"
   - assertVisible:
       text: ".*Promo section.*"
   - assertVisible:
       text: ".*Plan section.*"
   ```

### 2. Promotions Visible

Goal: Ensure promos load.

```yaml
- assertVisible:
    text: ".*Promo card.*"
```

Use `waitFor`/`repeat` if loading async.

### 3. Promotions Swipable

Goal: User can swipe promo carousel horizontally.

```yaml
- swipe:
    direction: LEFT
- assertVisible:
    text: ".*Promo card.*"
```

(Optionally swipe RIGHT, or assert different promo content if distinct.)

### 4. Plans Visible

Goal: Plans list appears.

```yaml
- scrollUntilVisible:
    element:
      text: ".*Plan card.*"
- assertVisible:
    text: ".*Plan card.*"
```

---

## Test Scenarios – Web

File: `maestro/web/screen_tests/home-screen-test.yaml`

Same semantics, adapted for web behaviour.

### 1. Home Loads (Web)

```yaml
- runFlow: ../../common_test/setup-home.yaml

- assertVisible:
    text: ".*Home screen.*"
- assertVisible:
    text: ".*Promo section.*"
- assertVisible:
    text: ".*Plan section.*"
```

### 2. Promotions Visible (Web)

```yaml
- assertVisible:
    text: ".*Promo card.*"
```

### 3. Promotions Navigable (Web)


```yaml
- swipe:
    direction: LEFT
- assertVisible:
    text: ".*Promo card.*"
```


### 4. Plans Visible (Web)

```yaml
- scrollUntilVisible:
    element:
      text: ".*Plan card.*"
- assertVisible:
    text: ".*Plan card.*"
```

---

## Keep in Mind

- Use regex with semantic labels (e.g. `".*Promo card.*"`).
- Keep `home-screen-test.yaml` focused on:
  - Presence of sections.
  - Basic interaction (swipe promos).
- Do not mix auth, bike detail, or rent flows here.
- Preserve this folder layout exactly:

  ```text
  maestro/
    all-tests.yaml
    mobile/
    web/
    common_test/
  ```

- Ensure semantics are identical across mobile/web so tests can be very similar.
