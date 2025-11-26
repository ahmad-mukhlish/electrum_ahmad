import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../viewmodel/notifiers/navigation_notifier.dart';

class MainScreenWeb extends HookConsumerWidget {
  const MainScreenWeb({
    super.key,
    required this.body,
    required this.onNavigate,
  });

  final Widget body;
  final void Function(BuildContext, int) onNavigate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationProvider);

    // useMemoized: Creates and caches SideMenuController instance
    //
    // Why use this hook?
    // - Without it, a new SideMenuController would be created on EVERY rebuild
    // - Widget rebuilds happen frequently (theme changes, state updates, etc.)
    // - Creating new controller on each rebuild causes:
    //   1. Memory leaks (old controllers not disposed)
    //   2. Lost state (controller resets to initial state)
    //   3. Performance issues (unnecessary object creation)
    //
    // How it works:
    // - Runs the callback ONLY ONCE when widget is first built
    // - Returns cached instance on subsequent rebuilds
    // - No dependency array = memoized forever (until widget is disposed)
    // - Similar to React's useMemo with empty deps []
    final sideMenuController = useMemoized(
      () => SideMenuController(initialPage: 0),
    );

    final colorScheme = Theme.of(context).colorScheme;

    // useEffect: Syncs SideMenuController with navigation state
    //
    // With ShellRoute:
    // - Route changes happen via GoRouter (context.go)
    // - ShellRoute swaps the child content automatically
    // - MainScreen.didChangeDependencies updates navigationProvider
    // - This effect keeps the sidebar visual selection in sync
    //
    // Flow: User clicks sidebar → context.go → route changes → child swaps
    //       → didChangeDependencies updates state → this effect updates sidebar UI
    useEffect(() {
      if (sideMenuController.currentPage != selectedIndex) {
        sideMenuController.changePage(selectedIndex);
      }
      return null;
    }, [selectedIndex]);

    return Scaffold(
      body: Row(
        children: [
          SideMenu(
            controller: sideMenuController,
            style: SideMenuStyle(
              displayMode: SideMenuDisplayMode.auto,
              showHamburger: true,
              hoverColor: colorScheme.secondary,
              selectedColor: colorScheme.primary,
              selectedTitleTextStyle: TextStyle(color: colorScheme.onPrimary),
              selectedIconColor: colorScheme.onPrimary,
              unselectedIconColor: colorScheme.onSurfaceVariant,
              unselectedTitleTextStyle: TextStyle(
                color: colorScheme.onSurfaceVariant,
              ),
              backgroundColor: colorScheme.secondary.withValues(alpha: 0.1),
            ),
            title: Column(
              children: [
                const SizedBox(height: 24),
                Text(
                  'Electrum ⚡',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                Divider(color: colorScheme.outlineVariant),
              ],
            ),
            items: [
              SideMenuItem(
                title: 'Home',
                onTap: (index, _) => onNavigate(context, index),
                icon: Icon(selectedIndex == 0
                    ? Icons.home
                    : Icons.home_outlined),
              ),
              SideMenuItem(
                title: 'Bikes',
                onTap: (index, _) => onNavigate(context, index),
                icon: Icon(selectedIndex == 1
                    ? Icons.motorcycle
                    : Icons.motorcycle_outlined),
              ),
              SideMenuItem(
                title: 'Profile',
                onTap: (index, _) => onNavigate(context, index),
                icon: Icon(selectedIndex == 2
                    ? Icons.person
                    : Icons.person_outline),
              ),
            ],
          ),
          Expanded(child: body),
        ],
      ),
    );
  }
}
