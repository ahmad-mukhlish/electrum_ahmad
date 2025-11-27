# Auth Maestro Tests Implementation Plan

## Overview

This plan outlines the implementation of end-to-end Maestro tests for the authentication feature (login, register, logout) covering both mobile and web platforms. The implementation follows the maestro-flutter skill pattern using entry point + runFlow organization.

**Key Requirements:**
- All testable widgets must have Semantics labels (2 words: First capitalized, second lowercase)
- Tests must work from clean install and be runnable independently
- Separate flows for mobile and web due to different layouts
- Use regex patterns for all Maestro assertions

---

## Phase 1: Add Semantics Labels to Flutter Code

### 1.1 Auth Form Widget (`lib/features/auth/presentation/widgets/shared/auth_form.dart`)

Wrap the following widgets with Semantics:

**Login Mode:**
- Login illustration/image → `"Login image"`
- Email text field → `"Login email"`
- Password text field → `"Login password"`
- Sign in button → `"Login button"`
- "Don't have account? Sign up" text button → `"Login signup"`

**Register Mode:**
- Email text field → `"Register email"`
- Password text field → `"Register password"`
- Register/Sign up button → `"Register button"`

**Implementation approach:**
- Check if auth_form.dart handles both login and register modes in one widget
- Add Semantics wrappers conditionally based on mode (isLogin vs isRegister)
- Ensure labels change appropriately when switching between modes

### 1.2 Main Screen Navigation

**Mobile Bottom Navigation Bar** (`lib/features/main/presentation/widgets/mobile/main_screen_mobile.dart`):
- Wrap the BottomNavigationBar widget → `"Home bottom"`

**Web Sidebar Navigation** (`lib/features/main/presentation/widgets/web/main_screen_web.dart`):
- Wrap the sidebar/navigation rail widget → `"Home sidebar"`

### 1.3 Profile Screen (`lib/features/profile/presentation/screens/profile_screen.dart`)

Add Semantics labels for:
- Profile navigation item (if separate from logout) → `"Profile menu"`
- Logout button → `"Logout button"`

**Implementation considerations:**
- Check if profile has multiple sections or just a logout button
- If profile tab is accessed via bottom nav, "Profile menu" refers to the tab tap
- Logout button should be clearly identifiable

### 1.4 Error Snackbar

**Location:** Check where error snackbars are displayed (likely in auth_notifier.dart or auth_screen.dart)

**Implementation approach:**
- Wrap SnackBar content with Semantics → `"Error snackbar"`
- Ensure this applies to auth-related errors (login/register failures)
- May need to add Semantics in the showSnackBar call or create a custom error widget

---

## Phase 2: Create Maestro Directory Structure

Create the following directory structure in the project root:

```
maestro/
├── all-tests.yaml                    # Entry point
├── common_tests/
│   └── auth-setup.yaml              # Shared setup flow
├── mobile/
│   └── auth-mobile.yaml             # Mobile-specific auth tests
└── web/
    └── auth-web.yaml                # Web-specific auth tests
```

**Note:** No code should be written yet, just create the directories and empty YAML files.

---

## Phase 3: Implement Common Test Flows

### 3.1 auth-setup.yaml

**Purpose:** Ensure the app starts from the login screen before all auth tests.

**High-level flow:**
1. Launch the app (may land on home if user is already logged in)
2. Check if user is logged in by looking for navigation elements
3. If logged in:
   - Navigate to Profile (tap profile tab/menu)
   - Tap logout button
4. Assert login screen is visible by checking for:
   - Login image
   - Login email field
   - Login password field
   - Login button

**Edge cases to handle:**
- First-time app launch (no user logged in)
- Returning user (already logged in)
- Need conditional logic to handle both states

---

## Phase 4: Implement Mobile Test Flows

### 4.1 auth-mobile.yaml Structure

This file orchestrates all mobile auth test scenarios in sequence:

1. Successful login with seeded user
2. Failed login with random credentials
3. Successful registration with random credentials
4. Failed registration with existing user
5. Logout flow

Each scenario should be clearly commented and use the common setup flow where needed.

### 4.2 Scenario 1: Successful Login (Seeded User)

**Flow:**
- Run auth-setup to ensure starting from login screen
- Tap Login email field, input: `ahmad.mukhlish.saputra@gmail.com`
- Tap Login password field, input: `CobaCoba123`
- Tap Login button
- Assert: Home bottom navigation is visible
- Assert: Error snackbar is NOT visible
- Optional: Assert home screen content is visible

### 4.3 Scenario 2: Failed Login (Random Credentials)

**Flow:**
- Run auth-setup to ensure starting from login screen
- Generate random email using Maestro variables (e.g., `test_${CURRENT_TIME}@example.com`)
- Generate random password
- Tap Login email field, input random email
- Tap Login password field, input random password
- Tap Login button
- Assert: Error snackbar IS visible
- Assert: Login button is still visible (still on login screen)
- Assert: Home bottom navigation is NOT visible

### 4.4 Scenario 3: Successful Registration (Random Credentials)

**Flow:**
- Run auth-setup to ensure starting from login screen
- Tap "Login signup" button to navigate to register screen
- Generate random email and password
- Tap Register email field, input random email
- Tap Register password field, input random password
- Tap Register button
- Assert: Home bottom navigation is visible
- Assert: Error snackbar is NOT visible

### 4.5 Scenario 4: Failed Registration (Existing User)

**Flow:**
- Run auth-setup to ensure starting from login screen
- Tap "Login signup" button to navigate to register screen
- Tap Register email field, input: `ahmad.mukhlish.saputra@gmail.com`
- Tap Register password field, input: `CobaCoba123`
- Tap Register button
- Assert: Error snackbar IS visible
- Assert: Register button is still visible (still on register screen)
- Assert: Home bottom navigation is NOT visible

### 4.6 Scenario 5: Logout Flow

**Precondition:** User must be logged in

**Flow:**
- If not already logged in, run successful login scenario first
- From home screen, tap Profile menu (profile tab in bottom nav)
- Tap Logout button
- Assert: Login image is visible
- Assert: Login email field is visible
- Assert: Login password field is visible
- Assert: Login button is visible
- Assert: Home bottom navigation is NOT visible

---

## Phase 5: Implement Web Test Flows

### 5.1 auth-web.yaml Structure

Similar to mobile but with web-specific layout assertions:
- Use "Home sidebar" instead of "Home bottom"
- All other semantics labels remain the same
- Same test scenarios as mobile

### 5.2 Web-Specific Considerations

**Differences from mobile:**
- After successful login: Assert `"Home sidebar"` is visible (not `"Home bottom"`)
- After failed login: Assert `"Home sidebar"` is NOT visible
- Logout flow: Navigate using sidebar profile menu

**Scenarios to implement:**
1. Successful login with seeded user
2. Failed login with random credentials
3. Successful registration with random credentials
4. Failed registration with existing user
5. Logout flow

All flows identical to mobile except for navigation element assertions.

---

## Phase 6: Create Entry Point (all-tests.yaml)

### 6.1 Master Test Orchestrator

**Purpose:** Single file that runs all auth tests in proper order.

**Structure:**
- Set app ID: `com.electrum.app`
- Run common setup (auth-setup.yaml)
- Run mobile tests (auth-mobile.yaml)
- Run web tests (auth-web.yaml)

**Execution considerations:**
- Each runFlow should be independent
- Setup flow ensures clean state before each test suite
- Tests should not interfere with each other

---

## Implementation Order

### Step 1: Add Semantics Labels (Flutter Code)
1. Start with auth_form.dart (most critical)
2. Add main screen navigation labels (mobile and web)
3. Add profile/logout labels
4. Add error snackbar semantics
5. Test manually that labels appear in Flutter DevTools

### Step 2: Create Maestro Directory Structure
1. Create maestro/ directory in project root
2. Create subdirectories: common_tests/, mobile/, web/
3. Create empty YAML files

### Step 3: Implement Setup Flow
1. Implement auth-setup.yaml first
2. Test it manually with `maestro test maestro/common_tests/auth-setup.yaml`
3. Ensure it handles both logged-in and logged-out states

### Step 4: Implement Mobile Tests
1. Start with Scenario 1 (successful login) - simplest happy path
2. Add Scenario 5 (logout) - completes the auth cycle
3. Add Scenario 2 (failed login) - error handling
4. Add Scenario 3 (successful registration)
5. Add Scenario 4 (failed registration)
6. Test each scenario individually before combining

### Step 5: Implement Web Tests
1. Copy mobile test structure
2. Replace navigation assertions (Home bottom → Home sidebar)
3. Test each scenario on web platform

### Step 6: Create Entry Point
1. Create all-tests.yaml
2. Wire up all flows using runFlow
3. Test complete suite end-to-end

### Step 7: Validation
1. Run on clean Android emulator
2. Run on clean iOS simulator
3. Run on web (Chrome)
4. Verify all scenarios pass
5. Verify tests can run independently

---

## Files to Create/Modify

### Flutter Files to Modify (Add Semantics)
- `lib/features/auth/presentation/widgets/shared/auth_form.dart`
- `lib/features/main/presentation/widgets/mobile/main_screen_mobile.dart`
- `lib/features/main/presentation/widgets/web/main_screen_web.dart`
- `lib/features/profile/presentation/screens/profile_screen.dart`
- Check where error snackbars are shown (likely in auth_notifier.dart or screens)

### Maestro Files to Create
- `maestro/all-tests.yaml`
- `maestro/common_tests/auth-setup.yaml`
- `maestro/mobile/auth-mobile.yaml`
- `maestro/web/auth-web.yaml`

---

## Success Criteria

### Semantics Implementation
- [ ] All widgets mentioned in brief have Semantics labels
- [ ] Labels follow naming convention (First capitalized, second lowercase)
- [ ] Labels are exactly 2 words
- [ ] Labels visible in Flutter DevTools Semantics tree
- [ ] No hardcoded/magic values - labels applied to actual widgets

### Maestro Tests
- [ ] All 5 scenarios implemented for mobile
- [ ] All 5 scenarios implemented for web
- [ ] Common setup flow handles both logged-in and logged-out states
- [ ] All tests pass on clean install
- [ ] Each test can run independently
- [ ] Tests use regex patterns for all assertions
- [ ] No test relies on execution order from previous tests
- [ ] Random credential generation works correctly

### Platform Coverage
- [ ] Tests pass on Android emulator
- [ ] Tests pass on iOS simulator
- [ ] Tests pass on web (Chrome)
- [ ] Mobile and web tests have appropriate layout assertions

### Documentation
- [ ] All flows have clear comments explaining purpose
- [ ] Entry point clearly shows test organization
- [ ] Each scenario documents expected behavior

---

## Testing Strategy

### Unit Testing Semantics
- Use Flutter DevTools to inspect widget tree
- Verify each Semantics label appears correctly
- Check labels switch properly between login/register modes

### Manual Maestro Testing
- Test each YAML file individually before integration
- Use `maestro test <file>` for individual scenarios
- Use `maestro studio` to inspect app hierarchy
- Verify selectors match actual widgets

### End-to-End Testing
- Run full suite with `maestro test maestro/all-tests.yaml`
- Test on fresh app installs to ensure no state pollution
- Verify tests work across different screen sizes
- Check performance (tests should complete in reasonable time)

---

## Notes

- **DO NOT write actual Maestro YAML or Dart code in this plan**
- Refer to maestro-flutter skill for specific Maestro command syntax
- Refer to brief.md for exact credentials and expected labels
- All Maestro selectors must use regex patterns with `.*Label.*` format
- Keep test flows focused and independent
- Use runFlow pattern extensively to promote reusability
- Consider adding wait conditions if UI animations cause timing issues
