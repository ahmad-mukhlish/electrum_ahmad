import 'package:electrum_ahmad/core/widgets/header_web.dart';
import 'package:electrum_ahmad/core/widgets/primary_app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../../auth/presentation/viewmodel/notifiers/auth_notifier.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.onPrimary,
      appBar: kIsWeb ? null : PrimaryAppBar(title: 'Profile'),
      body: Column(
        children: [
          if (kIsWeb)
            Padding(
              padding: const EdgeInsets.all(24),
              child: HeaderWeb(title: 'Profile'),
            ),
          Expanded(
            child: authState.when(
              data: (user) {
                if (user == null) {
                  return const Center(child: Text('No user data'));
                }
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    bottom: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      if (user.displayName != null) ...[
                        _buildInfoField(
                          label: 'Name',
                          value: user.displayName!,
                          context: context,
                          colorScheme: colorScheme,
                        ),
                        const SizedBox(height: 16),
                      ],
                      _buildInfoField(
                        label: 'Email',
                        value: user.email,
                        context: context,
                        colorScheme: colorScheme,
                      ),
                      const SizedBox(height: 24),
                      Expanded(child: Center(child: _buildProfileAnimation())),
                      const SizedBox(height: 24),
                      Center(child: _buildLogoutButton(ref, colorScheme, context)),
                      const SizedBox(height: 16),
                      _buildMadeWithLove(context, colorScheme),
                      const SizedBox(height: 24),
                    ],
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoField({
    required String label,
    required String value,
    required BuildContext context,
    required ColorScheme colorScheme,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: kIsWeb
              ? Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                )
              : Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: kIsWeb
              ? Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                )
              : Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
        ),
      ],
    );
  }

  Widget _buildLogoutButton(WidgetRef ref, ColorScheme colorScheme, BuildContext context) {
    return SizedBox(
      width: kIsWeb ? MediaQuery.of(context).size.width * 0.5 : double.infinity,
      child: FilledButton.icon(
        onPressed: () => ref.read(authProvider.notifier).logout(),
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.error,
          foregroundColor: colorScheme.onError,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        icon: const Icon(Icons.logout, size: kIsWeb ? 24 : 16,),
        label: const Text(
          'Logout',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: kIsWeb ? 32 : 16,
          ),
        ),
      ),
    );
  }

  Widget _buildProfileAnimation() {
    return Lottie.network(
      'https://lottie.host/ff05cfb6-cad9-49c8-a51a-591f26782267/Wdvz5uRSSD.json',
      repeat: true,
    );
  }

  Widget _buildMadeWithLove(BuildContext context, ColorScheme colorScheme) {
    return Center(
      child: Text(
        'Made with ❤️ by ahmad-mukhlish',
        style: kIsWeb
            ? Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              )
            : Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
