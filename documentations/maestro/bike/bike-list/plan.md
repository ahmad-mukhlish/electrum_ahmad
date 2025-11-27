# Maestro Bike Menu Test Plan

## Overview

This plan implements comprehensive Maestro test coverage for the Bike screen, including navigation, search, and filter functionality across both mobile and web platforms.

The implementation follows the established entry point + runFlow pattern with shared common flows and platform-specific flows.

---

## Files to Create

### Common Flows (maestro/common/)

#### 1. `bikes-setup.yaml`
- **Purpose**: Navigate to Bike screen from a clean state
- **Steps**:
  - Use existing auth-setup.yaml to ensure authenticated
  - Use existing setup-home.yaml to reach home screen
  - Tap on Bike menu navigation item
  - Assert Bike screen is visible
  - Assert Bike section (list container) is visible

#### 2. `bikes-assert-list.yaml`
- **Purpose**: Reusable assertion that bike list is showing with bikes
- **Steps**:
  - Assert Bike section is visible
  - Assert at least one Bike card is visible

#### 3. `bikes-assert-empty.yaml`
- **Purpose**: Reusable assertion that empty state is showing
- **Steps**:
  - Assert Bike empty (empty state widget) is visible
  - Assert Bike card is NOT visible

### Mobile Flow (maestro/mobile/flows/)

#### 4. `bikes-flow-mobile.yaml`
- **Purpose**: Complete mobile bike screen test suite
- **Scenarios to implement**:

  **A. Entry and Basic Navigation**
  - Run bikes-setup to navigate to bike screen
  - Run bikes-assert-list to confirm bikes are visible

  **B. Search Flow (Shared Behavior)**
  - Scroll to ensure bike cards are visible
  - Tap search field and input "H1"
  - Press Enter and assert Bike cards still visible (filtered results)
  - Clear search, input nonsense text "testesttestste"
  - Press Enter and run bikes-assert-empty
  - Tap Empty reset button
  - Run bikes-assert-list to confirm bikes return

  **C. Filter: Available Only**
  - Tap Filter button to open bottom sheet
  - Tap Filter available checkbox
  - Tap Filter apply button
  - Run bikes-assert-list
  - Assert Chip available is visible

  **D. Filter: Price Range - Premium**
  - Tap Filter button
  - Tap Filter premium option
  - Tap Filter apply
  - Run bikes-assert-list
  - Assert Chip premium is visible

  **E. Filter: Price Range - Deluxe (Empty Result)**
  - Tap Filter button
  - Tap Filter deluxe option
  - Tap Filter apply
  - Run bikes-assert-empty
  - Assert Chip premium is still visible (from previous filter)
  - Tap Chip premium to remove it
  - Run bikes-assert-list to confirm bikes return

  **F. Filter: Range Km - Long Range**
  - Tap Filter button
  - Tap Filter long option
  - Tap Filter apply
  - Run bikes-assert-list
  - Assert Chip range is visible

  **G. Filter: Reset**
  - Tap Filter button to open sheet
  - Tap Filter reset button
  - Run bikes-assert-list to confirm all bikes visible

### Web Flow (maestro/web/flows/)

#### 5. `bikes-flow-web.yaml`
- **Purpose**: Complete web bike screen test suite
- **Scenarios to implement**:

  **A. Entry and Basic Navigation**
  - Run bikes-setup to navigate to bike screen
  - Run bikes-assert-list to confirm bikes are visible

  **B. Search Flow (Shared Behavior)**
  - Same as mobile: search for "H1", search for nonsense, use Empty reset

  **C. Filter: Available Only**
  - Tap Filter available checkbox in sidebar (web has persistent sidebar)
  - Run bikes-assert-list

  **D. Filter: Price Range - Premium**
  - Tap Filter premium radio option
  - Run bikes-assert-list

  **E. Filter: Price Range - Deluxe (Empty Result)**
  - Tap Filter deluxe radio option
  - Run bikes-assert-empty

  **F. Filter: Reset Button**
  - Tap Filter reset button at bottom of sidebar
  - Run bikes-assert-list

  **G. Filter: Range Km - Long Range**
  - Tap Filter long option
  - Run bikes-assert-list

---

## Files to Modify

### 6. `maestro/all-tests.yaml`
- **Current content**: Orchestrates auth and home tests
- **Modification needed**: Add bike test flows after home tests
- **New runFlow entries**:
  - `mobile/flows/bikes-flow-mobile.yaml`
  - `web/flows/bikes-flow-web.yaml`
- **Order**: Auth flows → Home flows → Bike flows

---

## Flutter Code Changes Required

### Semantics Labels to Add

All semantics labels follow the 2-word pattern: First word capitalized, second word lowercase.

#### Shared Across Mobile and Web

**Navigation:**
- Bike menu navigation item needs: `Semantics(label: "Bike menu")`

**Screen Structure:**
- Bike screen root widget needs: `Semantics(label: "Bike screen")`
- Bike list section container needs: `Semantics(label: "Bike section")`

**List Items:**
- Each bike card needs: `Semantics(label: "Bike card")`

**Search:**
- Search text field needs: `Semantics(label: "Bike search")`

**Empty State:**
- Empty state widget needs: `Semantics(label: "Bike empty")`
- Empty state reset button needs: `Semantics(label: "Empty reset")`

#### Web-Specific Filter Semantics

**Filter Panel (Sidebar):**
- Available only checkbox: `Semantics(label: "Filter available")`
- Premium price radio: `Semantics(label: "Filter premium")`
- Deluxe price radio: `Semantics(label: "Filter deluxe")`
- Long range option: `Semantics(label: "Filter long")`
- Reset button at bottom: `Semantics(label: "Filter reset")`

#### Mobile-Specific Filter Semantics

**Filter Button:**
- Filter open button: `Semantics(label: "Filter button")`

**Filter Bottom Sheet Options:**
- Available only checkbox: `Semantics(label: "Filter available")`
- Premium price option: `Semantics(label: "Filter premium")`
- Deluxe price option: `Semantics(label: "Filter deluxe")`
- Long range option: `Semantics(label: "Filter long")`

**Filter Bottom Sheet Actions:**
- Apply button: `Semantics(label: "Filter apply")`
- Reset button: `Semantics(label: "Filter reset")`

**Active Filter Chips:**
- Available chip: `Semantics(label: "Chip available")`
- Premium chip: `Semantics(label: "Chip premium")`
- Range chip: `Semantics(label: "Chip range")`

---

## Implementation Steps

### Step 1: Add Semantics to Flutter Code
1. Locate bike screen navigation item (likely in main navigation)
2. Locate bike screen root widget
3. Locate bike list section container
4. Locate individual bike card widget
5. Locate search text field widget
6. Locate empty state widget and reset button
7. Locate web filter panel widgets (sidebar)
8. Locate mobile filter button, bottom sheet, and chip widgets
9. Wrap each with appropriate Semantics widget and label

### Step 2: Create Common Flows
1. Create `maestro/common/bikes-setup.yaml`
   - Reference existing common flows
   - Navigate from home to bike screen
   - Assert bike screen is visible

2. Create `maestro/common/bikes-assert-list.yaml`
   - Simple assertion flow
   - Check for bike section and bike cards

3. Create `maestro/common/bikes-assert-empty.yaml`
   - Simple assertion flow
   - Check for empty state, no bike cards

### Step 3: Create Mobile Flow
1. Create `maestro/mobile/flows/bikes-flow-mobile.yaml`
2. Implement entry setup using common flows
3. Implement search scenarios
4. Implement all mobile filter scenarios (A through G)
5. Each scenario should be clearly commented
6. Use runFlow to reference common assertion flows

### Step 4: Create Web Flow
1. Create `maestro/web/flows/bikes-flow-web.yaml`
2. Implement entry setup using common flows
3. Implement search scenarios (same as mobile)
4. Implement all web filter scenarios (C through G)
5. Each scenario should be clearly commented
6. Use runFlow to reference common assertion flows

### Step 5: Update Test Orchestrator
1. Open `maestro/all-tests.yaml`
2. Add bike flow entries after home flows
3. Maintain clear section comments
4. Ensure proper relative paths

### Step 6: Verify Test Structure
1. Confirm all new files are in correct locations
2. Verify all runFlow paths use correct relative references
3. Check that common flows are reused appropriately

---

## Key Differences: Mobile vs Web

### Filter Interaction Model

**Web:**
- Filter panel is always visible in sidebar
- Filters apply immediately on click (no Apply button)
- No filter chips (filters shown in sidebar)
- Reset button at bottom of sidebar

**Mobile:**
- Filter button opens bottom sheet/dialog
- Filters require Apply button to take effect
- Applied filters shown as chips above list
- Chips can be individually removed by tapping
- Reset button inside filter sheet

### Search Behavior
- Search behavior is identical between platforms
- Both use same "Bike search" semantic label
- Both support text input and Enter key

---

## Files Structure Summary

```
maestro/
├── all-tests.yaml                      [MODIFY] Add bike flows
├── common/
│   ├── auth-setup.yaml                [EXISTS]
│   ├── setup-home.yaml                [EXISTS]
│   ├── bikes-setup.yaml               [CREATE]
│   ├── bikes-assert-list.yaml         [CREATE]
│   └── bikes-assert-empty.yaml        [CREATE]
├── mobile/
│   └── flows/
│       ├── auth-flow-mobile.yaml      [EXISTS]
│       ├── home-flow-mobile.yaml      [EXISTS]
│       └── bikes-flow-mobile.yaml     [CREATE]
└── web/
    └── flows/
        ├── auth-flow-web.yaml         [EXISTS]
        ├── home-flow-web.yaml         [EXISTS]
        └── bikes-flow-web.yaml        [CREATE]
```

**Total files to create:** 5 new YAML files
**Total files to modify:** 1 existing YAML file
**Flutter files to modify:** Multiple (add Semantics labels)

---

## Success Criteria

- [ ] All Semantics labels added to Flutter code
- [ ] Three common flows created and working
- [ ] Mobile bike flow created with all scenarios
- [ ] Web bike flow created with all scenarios
- [ ] all-tests.yaml updated to include bike flows
- [ ] All tests pass when run via `maestro test maestro/all-tests.yaml`
- [ ] Individual flows can be run independently
- [ ] Common flows properly reused across mobile and web
- [ ] Empty state properly tested in both platforms
- [ ] Search functionality verified in both platforms
- [ ] Filter behavior verified per platform (mobile vs web differences)
- [ ] All regex patterns using `.*Label.*` format work correctly
