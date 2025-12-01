import 'package:flutter/foundation.dart'; // ⬅️ for ValueNotifier
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/domain/entities/user.dart';
import '../../features/auth/presentation/screens/auth_screen.dart';
import '../../features/auth/presentation/viewmodel/notifiers/auth_notifier.dart';
import '../../features/bikes/domain/entities/bike.dart';
import '../../features/bikes/presentation/screens/bike_detail_screen.dart';
import '../../features/bikes/presentation/screens/bikes_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/main/presentation/screens/main_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/rents/domain/entities/rent/rent.dart';
import '../../features/rents/presentation/screens/bike_renting_screen.dart';
import '../../features/rents/presentation/screens/rent_detail_screen.dart';

part 'routing.g.dart';

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  //Bridge from Riverpod to listanable : a Listenable for GoRouter
  //TODO @ahmad-mukhlis consider to move this into separate class / provider
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
      // ShellRoute: Keeps MainScreen alive, only swaps child content
      // Benefits:
      // - No full page rebuilds when navigating between tabs
      // - Sidebar/navbar stays persistent
      // - Better performance (controllers, state preserved)
      // - Still maintains URL changes and deep linking
      ShellRoute(
        builder: (context, state, child) => MainScreen(body: child),
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (context, state) => NoTransitionPage(
              child: const HomeScreen(),
            ),
          ),
          GoRoute(
            path: '/bikes',
            pageBuilder: (context, state) => NoTransitionPage(
              child: const BikesScreen(),
            ),
          ),
          GoRoute(
            path: '/profile',
            pageBuilder: (context, state) => NoTransitionPage(
              child: const ProfileScreen(),
            ),
          ),
        ],
      ),
      // Detail routes outside ShellRoute - no navbar/sidebar
      GoRoute(
        path: '/bikes/:bikeId',
        builder: (context, state) {
          final bikeId = state.pathParameters['bikeId']!;
          return BikeDetailScreen(bikeId: bikeId);
        },
        routes: [
          GoRoute(
            path: 'interest',
            builder: (context, state) {
              final bike = state.extra as Bike;
              return BikeRentingScreen(bike: bike);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/profile/rent/:rentId',
        builder: (context, state) {
          final rent = state.extra as Rent;
          return RentDetailScreen(rent: rent);
        },
      ),
    ],
  );
}
