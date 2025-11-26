import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../auth/presentation/viewmodel/notifiers/auth_notifier.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authProvider.notifier).logout(),
          ),
        ],
      ),
      body: authState.when(
        data: (user) {
          if (user == null) {
            return const Center(child: Text('No user data'));
          }

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 8),
                  _buildUserInfo(
                    user.email,
                    Theme.of(context).textTheme.bodyLarge,
                    colorScheme,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Welcome to Electrum! ⚡',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildProfilePhoto(String? photoUrl, ColorScheme colorScheme) {
    return CircleAvatar(
      radius: 50,
      backgroundColor: colorScheme.primaryContainer,
      backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
      child: photoUrl == null
          ? Icon(Icons.person, size: 50, color: colorScheme.onPrimaryContainer)
          : null,
    );
  }

  Widget _buildUserInfo(
    String text,
    TextStyle? style,
    ColorScheme colorScheme,
  ) {
    return Text(
      text,
      style: style?.copyWith(
        fontWeight: FontWeight.bold,
        color: colorScheme.onSurface,
      ),
      textAlign: TextAlign.center,
    );
  }
}
