# Main Screen Navigation Implementation Plan

## Overview
Implement main-screen navigation with sidebar for web and bottom navbar for mobile, using a shared navigation provider. The navigation includes three menus: Home, Bikes, and Profile.

## Dependencies to Add

```yaml
# pubspec.yaml
dependencies:
  easy_sidemenu: ^0.6.0  # For web sidebar navigation
```

## Architecture Overview

```
lib/
  features/
    main/
      presentation/
        viewmodel/
          notifiers/
            navigation_notifier.dart      # Notifier for navigation state
            navigation_notifier.g.dart
          states/
            navigation_state.dart         # Freezed state for navigation
            navigation_state.freezed.dart
            navigation_state.g.dart
        screens/
          main_screen.dart                # Platform-agnostic entry point
        widgets/
          mobile/
            main_screen_mobile.dart       # Bottom navbar implementation
          web/
            main_screen_web.dart          # Sidebar implementation
    home/
      presentation/
        screens/
          home_screen.dart                # New empty home screen
    bikes/
      presentation/
        screens/
          bikes_screen.dart               # New empty bikes screen
    profile/
      presentation/
        screens/
          profile_screen.dart             # Moved from current home_screen
```

## Implementation Steps

### Step 1: Install Dependencies
```bash
flutter pub add easy_sidemenu
```

### Step 2: Create Navigation State (Freezed)

**File**: `lib/features/main/presentation/viewmodel/states/navigation_state.dart`

- Create sealed class `NavigationState` with freezed
- Properties:
  - `selectedIndex` (int, default: 0)
  - Optional properties for future expansion

### Step 3: Create Navigation Notifier

**File**: `lib/features/main/presentation/viewmodel/notifiers/navigation_notifier.dart`

- Create `NavigationNotifier` extending `_$NavigationNotifier`
- Use `@riverpod` annotation
- Methods:
  - `build()` → initial state with selectedIndex = 0
  - `setSelectedIndex(int index)` → update selected menu
- State management: use `NavigationState`

### Step 4: Create Profile Screen

**File**: `lib/features/profile/presentation/screens/profile_screen.dart`

- Move content from current `home_screen.dart`
- Keep the user info display and logout button
- Update to use proper theming and layout
- Should display:
  - User display name or email
  - User email
  - Welcome message
  - Logout button

### Step 5: Create Empty Home Screen

**File**: `lib/features/home/presentation/screens/home_screen.dart`

- Create new simple scaffold with "Home" title
- Placeholder content: Center with "Home Screen - Coming Soon"
- Will be populated in future tasks

### Step 6: Create Empty Bikes Screen

**File**: `lib/features/bikes/presentation/screens/bikes_screen.dart`

- Create simple scaffold with "Bikes" title
- Placeholder content: Center with "Bikes Screen - Coming Soon"
- Will be populated in future tasks

### Step 7: Create Mobile Main Screen

**File**: `lib/features/main/presentation/widgets/mobile/main_screen_mobile.dart`

- Use `Scaffold` with `bottomNavigationBar`
- Navigation items:
  1. Home: Icon.home_outlined / Icons.home (filled)
  2. Bikes: Icons.motorcycle_outlined / Icons.motorcycle (filled)
  3. Profile: Icons.person_outline / Icons.person (filled)
- Body: Display selected screen based on `navigationProvider` state
- `onTap`: call `navigationNotifier.setSelectedIndex(index)`
- Icons change based on selection (outlined when not selected, filled when selected)

### Step 8: Create Web Main Screen

**File**: `lib/features/main/presentation/widgets/web/main_screen_web.dart`

- Use `easy_sidemenu` package
- Create `SideMenu` with `SideMenuController`
- Sync controller with `navigationProvider`
- SideMenu items:
  1. Home: same icons as mobile
  2. Bikes: same icons as mobile
  3. Profile: same icons as mobile
- Use `Row`: [SideMenu | Expanded(selectedScreen)]
- Responsive: sidebar remains but adjusts width/style for narrow screens (e.g., collapsible or compact mode)
- Icons change based on selection

### Step 9: Create Main Screen Entry Point

**File**: `lib/features/main/presentation/screens/main_screen.dart`

- Platform-agnostic entry
- Use `kIsWeb` to determine platform
- Return `MainScreenWeb()` for web, `MainScreenMobile()` for mobile

### Step 10: Update Routing

**File**: `lib/core/routing/routing.dart`

- Update home route `/` to use `MainScreen` instead of `HomeScreen`
- Add nested routes (optional, for deep linking):
  - `/` → MainScreen (Home tab)
  - `/bikes` → MainScreen (Bikes tab)
  - `/profile` → MainScreen (Profile tab)
- Ensure routes are protected by auth redirect logic

## Icon Mapping

| Menu    | Outlined Icon               | Filled Icon        |
|---------|-----------------------------|--------------------|
| Home    | Icons.home_outlined         | Icons.home         |
| Bikes   | Icons.motorcycle_outlined   | Icons.motorcycle   |
| Profile | Icons.person_outline        | Icons.person       |

## Navigation Flow

1. User logs in → redirected to `/` (MainScreen with Home tab selected)
2. User clicks "Bikes" → `navigationNotifier.setSelectedIndex(1)` → BikesScreen displayed
3. User clicks "Profile" → `navigationNotifier.setSelectedIndex(2)` → ProfileScreen displayed
4. Direct link `/profile` → MainScreen with Profile tab selected (if logged in)

## State Management Pattern

```dart
// Watch navigation state
final navState = ref.watch(navigationProvider);

// Update navigation
ref.read(navigationProvider.notifier).setSelectedIndex(1);

// Get current index
final currentIndex = navState.selectedIndex;
```

## Responsive Design

- **Mobile**: Always use BottomNavigationBar
- **Web**: Always use Sidebar (responsive - adjusts width/style based on screen size, but remains a sidebar)

## Key Considerations

1. **Clean Architecture**: Navigation logic in presentation layer, no business logic
2. **Single Source of Truth**: `navigationNotifier` controls navigation state for both platforms
3. **Icons**: Use outlined/filled variants for better UX
4. **Responsive**: Web always uses sidebar (responsive width/style), mobile always uses bottom navbar
5. **Deep Linking**: All routes accessible via direct URLs (when logged in)
6. **Code Generation**: Run `dart run build_runner build --delete-conflicting-outputs` after creating freezed/riverpod files

## Migration Notes

- Current `HomeScreen` content → moved to `ProfileScreen`
- Current `/` route → now points to `MainScreen` (displays HomeScreen tab by default)
- Logout functionality → moved to ProfileScreen

## User Reminder

After implementation, run:
```bash
dart run build_runner build --delete-conflicting-outputs
flutter analyze
```
