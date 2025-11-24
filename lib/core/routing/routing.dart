import 'package:flutter/foundation.dart'; // ⬅️ for ValueNotifier
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/viewmodel/notifiers/auth_notifier.dart';
import '../../features/home/presentation/screens/home_screen.dart';

part 'routing.g.dart';

@riverpod
GoRouter router(Ref ref) {
  // NEW: bridge Riverpod auth -> a Listenable for GoRouter
  final auth = ValueNotifier<AsyncValue<bool>>(const AsyncLoading());
  ref.onDispose(auth.dispose);

  ref.listen<AsyncValue<bool>>(authProvider, (_, next) {
    auth.value = next;
  });

  return GoRouter(
    initialLocation: '/',
    // NEW: tell GoRouter to refresh redirects when auth changes
    refreshListenable: auth,
    redirect: (context, state) {
      final authState = auth.value; // ⬅️ was: ref.watch(authProvider)

      final isLoading = authState.isLoading;
      final isLoggedIn = authState.value ?? false;
      final isLoginRoute = state.matchedLocation == '/login';

      if (isLoading) {
        return null;
      }

      if (!isLoggedIn && !isLoginRoute) {
        return '/login';
      }
      if (isLoggedIn && isLoginRoute) {
        return '/';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}