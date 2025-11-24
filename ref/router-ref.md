
When building Flutter apps, managing navigation and state effectively is critical for creating smooth and responsive user experiences. The combination of go_router and Riverpod provides a powerful toolkit to achieve this. In this guide, we’ll explore how to integrate go_router with Riverpod to build a scalable and maintainable Flutter application.

Why Use go_router and Riverpod Together?
go_router: Simplifies navigation in Flutter, making it easy to manage dynamic routing, deep linking, and nested navigation.
Riverpod: A modern state management library that ensures flexibility, testability, and reactivity in Flutter applications.
Together, these tools enable:

State-aware routing (e.g., redirecting based on authentication state).
Clear separation of concerns for better maintainability.
Enhanced scalability for complex apps.
Setting Up go_router and Riverpod
1. Add Dependencies
Include the necessary packages in your pubspec.yaml:

dependencies:
  flutter:
    sdk: flutter
  go_router: ^6.0.0
  flutter_riverpod: ^2.0.0
Run the command to install them:

flutter pub get
2. Define Your App State with Riverpod
Create a Provider to manage the app’s state, such as user authentication.

import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateProvider<bool>((ref) => false);
Here, authProvider tracks whether the user is logged in or not.

Become a member
3. Configure go_router with State-Aware Redirects
Set up go_router and integrate it with the Riverpod authProvider:

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,
    );
  }
}
final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => DashboardPage(),
    ),
  ],
  redirect: (context, state) {
    final authState = context.read(authProvider);
    final isLoggedIn = authState.state;
    if (state.subloc == '/dashboard' && !isLoggedIn) {
      return '/login';
    }
    if (state.subloc == '/login' && isLoggedIn) {
      return '/dashboard';
    }
    return null;
  },
);
Here’s what’s happening:

The redirect function checks the user’s authentication state.
If the user tries to access the dashboard while not logged in, they’re redirected to the login page.
If already logged in, they’re redirected to the dashboard.
4. Update State Based on User Actions
Update the authentication state using Riverpod:

class LoginPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ref.read(authProvider).state = true; // User logs in
            context.go('/dashboard');
          },
          child: Text('Login'),
        ),
      ),
    );
  }
}
Similarly, add a logout button in the dashboard:

class DashboardPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              ref.read(authProvider).state = false; // User logs out
              context.go('/login');
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Welcome to the Dashboard!'),
      ),
    );
  }
}
Benefits of This Approach
Seamless Navigation: go_router handles navigation while Riverpod manages state changes.
Easy Maintenance: Clear separation between routing logic and app state.
Dynamic Redirects: Automatically navigate users based on their authentication state or other conditions.
Scalable: Add more routes and states without complicating the structure.
Conclusion
By combining go_router and Riverpod, you can create apps that are not only responsive and dynamic but also easy to manage as they grow. This approach ensures your navigation and state management work together seamlessly, resulting in a smooth user experience. Give it a try, and elevate your Flutter development game! 🚀