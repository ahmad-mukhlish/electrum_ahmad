import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/services/bike_seeder.dart';

/// Debug screen for seeding bike data to Firestore
class BikeSeederScreen extends ConsumerWidget {
  const BikeSeederScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seederState = ref.watch(bikeSeederProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.two_wheeler,
              size: kIsWeb ? 120 : 100,
              color: colorScheme.primary,
            ),
            const SizedBox(height: 32),
            Text(
              'Seed Bike Data',
              style: (kIsWeb
                      ? textTheme.displayMedium
                      : textTheme.headlineMedium)
                  ?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSecondary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'This will seed 10 Electrum bikes to Firestore.\n'
              'Existing bikes with the same IDs will be overwritten.',
              textAlign: TextAlign.center,
              style:
                  (kIsWeb ? textTheme.bodyLarge : textTheme.bodyMedium)?.copyWith(
                color: colorScheme.onSecondary.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 32),
            seederState.when(
              data: (_) => Column(
                children: [
                  Icon(
                    Icons.check_circle,
                    size: kIsWeb ? 80 : 60,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Bikes seeded successfully!',
                    style: (kIsWeb
                            ? textTheme.headlineSmall
                            : textTheme.titleMedium)
                        ?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) => Column(
                children: [
                  Icon(
                    Icons.error,
                    size: kIsWeb ? 80 : 60,
                    color: colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: $error',
                    style: (kIsWeb ? textTheme.bodyLarge : textTheme.bodyMedium)
                        ?.copyWith(
                      color: colorScheme.error,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: kIsWeb ? 400 : double.infinity),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: seederState.isLoading
                      ? null
                      : () => ref.read(bikeSeederProvider.notifier).seedBikes(),
                  style: FilledButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    padding: EdgeInsets.symmetric(vertical: kIsWeb ? 20 : 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.upload),
                  label: Text(
                    seederState.isLoading ? 'Seeding...' : 'Seed Bikes',
                    style: (kIsWeb
                            ? textTheme.headlineSmall
                            : textTheme.bodyLarge)
                        ?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
