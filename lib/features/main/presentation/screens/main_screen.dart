import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/enum/main_nav_destination.dart';
import '../viewmodel/notifiers/navigation_notifier.dart';
import '../widgets/mobile/main_screen_mobile.dart';
import '../widgets/web/main_screen_web.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key, required this.child});

  final Widget child;

  static void navigateToIndex(BuildContext context, int index) =>
      context.go(MainNavDestination.fromIndex(index).path);

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Sync navigation state with current route
    // This runs when route changes (including deep links and browser back/forward)
    final currentPath = GoRouterState.of(context).uri.path;
    final index = MainNavDestination.fromPath(currentPath).idx;

    // Only update if different to avoid unnecessary rebuilds
    if (ref.read(navigationProvider) != index) {
      // Delay state modification to after the current frame to avoid lifecycle conflicts
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(navigationProvider.notifier).setSelectedIndex(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) => kIsWeb
      ? MainScreenWeb(
          onNavigate: MainScreen.navigateToIndex,
          body: widget.child,
        )
      : MainScreenMobile(
          onNavigate: MainScreen.navigateToIndex,
          body: widget.child,
        );
}
