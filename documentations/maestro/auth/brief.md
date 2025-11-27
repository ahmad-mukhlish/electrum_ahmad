# Auth Maestro Tests Brief

## Context
- End-to-end test the **auth feature** (login, register, logout) for **mobile** and **web**.
- Use Maestro + Flutter following the **entry point + runFlow** pattern from `maestro-flutter` skill.
- Tests will live under:

  ```text
  maestro/
    all-tests.yaml

    common_tests/
      auth-setup.yaml        # shared flows (e.g. go to login, clear fields)

    mobile/
      auth-mobile.yaml       # mobile-specific auth flows

    web/
      auth-web.yaml          # web-specific auth flows
  ```

- Seeded user:
  - email: `ahmad.mukhlish.saputra@gmail.com`
  - password: `CobaCoba123`

- Example `all-tests.yaml`:

  ```yaml
  appId: com.electrum.app
  ---
  - runFlow: common_tests/auth-setup.yaml
  - runFlow: mobile/auth-mobile.yaml
  - runFlow: web/auth-web.yaml
  ```

---

## Semantics (CRITICAL, MAX 2 WORDS)

All testable widgets must be wrapped with `Semantics` and given a **2-word label** that follows the skill convention:

- First word capitalized, second word lowercase.
- Examples: `"Login button"`, `"Login image"`, `"Home bottom"`.

In Maestro, always match using regex:

```yaml
- assertVisible:
    text: ".*Login button.*"
- tapOn:
    text: ".*Logout button.*"
```

### Suggested labels (max 2 words)

**Login screen**

```dart
Semantics(label: "Login image", child: loginIllustration);
Semantics(label: "Login email", child: emailTextField);
Semantics(label: "Login password", child: passwordTextField);
Semantics(label: "Login button", child: signInButton);
Semantics(label: "Login signup", child: goToRegisterButton); // “Don’t have account? Sign up”
```

**Register screen**

```dart
Semantics(label: "Register email", child: registerEmailField);
Semantics(label: "Register password", child: registerPasswordField);
Semantics(label: "Register button", child: registerButton);
```

**Home / layout**

```dart
// Mobile bottom nav
Semantics(label: "Home bottom", child: bottomNavigationBar);

// Web sidebar nav
Semantics(label: "Home sidebar", child: sidebarNavigation);
```

**Profile + logout**

```dart
Semantics(label: "Profile menu", child: profileMenuButton);
Semantics(label: "Logout button", child: logoutButton);
```

**Error snackbar**

```dart
Semantics(label: "Error snackbar", child: errorSnackBar);
```

---

## Test Organization

### `common_tests/auth-setup.yaml`

Purpose:
- Launch app.
- Ensure we end up on Login screen for all auth tests.

Flow (conceptual):

- If already logged in:
  - Tap `"Profile menu"` → tap `"Logout button"`.
- Assert Login screen is visible:

```yaml
- assertVisible:
    text: ".*Login image.*"
- assertVisible:
    text: ".*Login email.*"
- assertVisible:
    text: ".*Login password.*"
- assertVisible:
    text: ".*Login button.*"
```

### `mobile/auth-mobile.yaml`

Contains all **mobile** auth scenarios:
- Successful login (seeded user).
- Failed login (random credentials).
- Successful registration (random credentials).
- Failed registration (existing user).
- Logout.

### `web/auth-web.yaml`

Same scenarios as mobile, but with **web layout** assertions:
- `Home sidebar` instead of `Home bottom`.

---

## Scenarios – Mobile (`maestro/mobile/auth-mobile.yaml`)

### 1. Successful Login (seeded user)

**Given**
- `auth-setup.yaml` has run and Login screen is visible.

**Steps**
- Tap `"Login email"` and type `ahmad.mukhlish.saputra@gmail.com`.
- Tap `"Login password"` and type `CobaCoba123`.
- Tap `"Login button"`.

**Assertions**

```yaml
- assertVisible:
    text: ".*Home bottom.*"
- assertNotVisible:
    text: ".*Error snackbar.*"
```

Optionally also assert some Home header text (e.g. “Your next ride”).

---

### 2. Failed Login (random credentials)

**Steps**
- Tap `"Login email"`, type random email (e.g. using Maestro `${CURRENT_TIME}`).
- Tap `"Login password"`, type random password.
- Tap `"Login button"`.

**Assertions**

```yaml
- assertVisible:
    text: ".*Error snackbar.*"
- assertVisible:
    text: ".*Login button.*"      # still on login
- assertNotVisible:
    text: ".*Home bottom.*"
```

---

### 3. Successful Registration (random credentials)

**Steps**
- From Login, tap `"Login signup"` to go to Register.
- On Register:
  - Tap `"Register email"` and type random email.
  - Tap `"Register password"` and type random password.
- Tap `"Register button"`.

**Assertions**

```yaml
- assertVisible:
    text: ".*Home bottom.*"
- assertNotVisible:
    text: ".*Error snackbar.*"
```

---

### 4. Failed Registration (existing user)

**Steps**
- From Login, tap `"Login signup"`.
- On Register:
  - `"Register email"` = `ahmad.mukhlish.saputra@gmail.com`
  - `"Register password"` = `CobaCoba123`
- Tap `"Register button"`.

**Assertions**

```yaml
- assertVisible:
    text: ".*Error snackbar.*"
- assertVisible:
    text: ".*Register button.*"
- assertNotVisible:
    text: ".*Home bottom.*"
```

---

### 5. Logout Flow

**Precondition**
- User is logged in (e.g. after successful login test or via separate `runFlow`).

**Steps**
- From Home:
  - Tap `"Profile menu"`.
  - Tap `"Logout button"`.

**Assertions**

```yaml
- assertVisible:
    text: ".*Login image.*"
- assertVisible:
    text: ".*Login email.*"
- assertVisible:
    text: ".*Login password.*"
- assertVisible:
    text: ".*Login button.*"
- assertNotVisible:
    text: ".*Home bottom.*"
```

---

## Scenarios – Web (`maestro/web/auth-web.yaml`)

Same flows as mobile, layout checks differ.

### 1. Successful Login (seeded user)

**Steps**
- Use same login steps:
  - `"Login email"` → `ahmad.mukhlish.saputra@gmail.com`
  - `"Login password"` → `CobaCoba123`
  - `"Login button"`.

**Assertions**

```yaml
- assertVisible:
    text: ".*Home sidebar.*"
- assertNotVisible:
    text: ".*Error snackbar.*"
```

---

### 2. Failed Login (random credentials)

**Steps**
- Random email + random password.
- Tap `"Login button"`.

**Assertions**

```yaml
- assertVisible:
    text: ".*Error snackbar.*"
- assertVisible:
    text: ".*Login button.*"
- assertNotVisible:
    text: ".*Home sidebar.*"
```

---

### 3. Successful Registration (random credentials)

**Steps**
- Tap `"Login signup"` to go to Register.
- Fill `"Register email"` and `"Register password"` with random values.
- Tap `"Register button"`.

**Assertions**

```yaml
- assertVisible:
    text: ".*Home sidebar.*"
- assertNotVisible:
    text: ".*Error snackbar.*"
```

---

### 4. Failed Registration (existing user)

**Steps**
- `"Register email"` = `ahmad.mukhlish.saputra@gmail.com`
- `"Register password"` = `CobaCoba123`
- Tap `"Register button"`.

**Assertions**

```yaml
- assertVisible:
    text: ".*Error snackbar.*"
- assertVisible:
    text: ".*Register button.*"
- assertNotVisible:
    text: ".*Home sidebar.*"
```

---

### 5. Logout Flow

**Precondition**
- User is logged in on web.

**Steps**
- From Home:
  - Tap `"Profile menu"` (in sidebar / top bar).
  - Tap `"Logout button"`.

**Assertions**

```yaml
- assertVisible:
    text: ".*Login image.*"
- assertVisible:
    text: ".*Login email.*"
- assertVisible:
    text: ".*Login password.*"
- assertVisible:
    text: ".*Login button.*"
- assertNotVisible:
    text: ".*Home sidebar.*"
```

---

## Keep in Mind

- **Semantics labels**:
  - Always 2 words where used for testing.
  - First word capitalized, second lowercase: `"Login button"`, `"Home bottom"`, `"Error snackbar"`.
- **Maestro selectors**:
  - Always use regex patterns with `.*Label.*` to avoid brittle matches.
- **Structure**:
  - Reuse `common_tests/auth-setup.yaml` for initial state.
  - Keep each scenario in `auth-mobile.yaml` / `auth-web.yaml` small and focused.
- All flows must:
  - Work from a **clean install**.
  - Be runnable **independently**.
  - Not rely on hidden ordering between tests.
