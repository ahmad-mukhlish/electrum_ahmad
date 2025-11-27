import 'package:electrum_ahmad/core/widgets/header_web.dart';
import 'package:electrum_ahmad/core/widgets/primary_app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../auth/presentation/viewmodel/notifiers/auth_notifier.dart';
import '../../../bikes/domain/entities/rent.dart';
import '../../../bikes/presentation/viewmodel/notifiers/rent_history_notifier.dart';
import '../../../bikes/presentation/widgets/shared/rent_history_list.dart';

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
                      _buildRentHistorySection(
                        context,
                        ref,
                        colorScheme,
                      ),
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

  Widget _buildRentHistorySection(
    BuildContext context,
    WidgetRef ref,
    ColorScheme colorScheme,
  ) {
    final textTheme = Theme.of(context).textTheme;
    final rentHistoryAsync = ref.watch(rentHistoryProvider);

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rent History',
            style: kIsWeb
                ? textTheme.headlineLarge?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  )
                : textTheme.titleLarge?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: rentHistoryAsync.when(
              data: (rents) => RentHistoryList(
                rents: rents,
                onRentTap: (rent) => _showRentDetail(context, rent),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => _buildErrorState(
                context,
                ref,
                colorScheme,
                textTheme,
                error,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(
    BuildContext context,
    WidgetRef ref,
    ColorScheme colorScheme,
    TextTheme textTheme,
    Object error,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: kIsWeb ? 80 : 60,
            color: colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            'Failed to load rent history',
            style: kIsWeb
                ? textTheme.headlineSmall?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  )
                : textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kIsWeb ? 48 : 24),
            child: Text(
              error.toString(),
              style: kIsWeb
                  ? textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    )
                  : textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () => ref.invalidate(rentHistoryProvider),
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
            style: FilledButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              padding: EdgeInsets.symmetric(
                horizontal: kIsWeb ? 32 : 24,
                vertical: kIsWeb ? 16 : 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showRentDetail(BuildContext context, Rent rent) {
    context.go('/profile/rent/${rent.id}', extra: rent);
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
