import 'package:flutter/foundation.dart'; // ⬅️ for ValueNotifier
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/domain/entities/user.dart';
import '../../features/auth/presentation/screens/auth_screen.dart';
import '../../features/auth/presentation/viewmodel/notifiers/auth_notifier.dart';
import '../../features/home/presentation/screens/home_screen.dart';

part 'routing.g.dart';

@riverpod
GoRouter router(Ref ref) {
  //Bridge from Riverpod to listanable : a Listenable for GoRouter
  final listenable = ValueNotifier<AsyncValue<User?>>(const AsyncLoading());
  ref.onDispose(listenable.dispose);

  ref.listen<AsyncValue<User?>>(authProvider, (_, next) {
    listenable.value = next;
  });

  return GoRouter(
    initialLocation: '/',
    //Tell GoRouter to refresh redirects when listenable changes
    refreshListenable: listenable,
    redirect: (context, state) {
      final authState = listenable.value;

      final isLoading = authState.isLoading;
      final isLoggedIn = authState.value != null;
      final isAuthRoute = state.matchedLocation == '/login';

      if (isLoading) {
        return null;
      }

      if (!isLoggedIn && !isAuthRoute) {
        return '/login';
      }
      if (isLoggedIn && isAuthRoute) {
        return '/';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}