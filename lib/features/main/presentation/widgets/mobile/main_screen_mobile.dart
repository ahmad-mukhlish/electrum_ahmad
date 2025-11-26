import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../viewmodel/notifiers/navigation_notifier.dart';

class MainScreenMobile extends ConsumerWidget {
  const MainScreenMobile({
    super.key,
    required this.body,
    required this.onNavigate,
  });

  final Widget body;
  final void Function(BuildContext, int) onNavigate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) => onNavigate(context, index),
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurfaceVariant,
        items: [
          BottomNavigationBarItem(
            icon: Icon(selectedIndex == 0
                ? Icons.home
                : Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(selectedIndex == 1
                ? Icons.motorcycle
                : Icons.motorcycle_outlined),
            label: 'Bikes',
          ),
          BottomNavigationBarItem(
            icon: Icon(selectedIndex == 2
                ? Icons.person
                : Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
