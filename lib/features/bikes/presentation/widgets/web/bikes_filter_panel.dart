import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../viewmodel/notifiers/filter/bike_filter_provider.dart';
import '../shared/availability_toggle.dart';
import '../shared/price_bucket_selector.dart';
import '../shared/range_bucket_selector.dart';
import 'bikes_search_field_web.dart';

class BikesFilterPanel extends ConsumerWidget {
  const BikesFilterPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final bikesCount = ref.watch(
      bikeFilterProvider.select((state) => state.filteredBikes.length),
    );

    final showAvailableOnly = ref.watch(
      bikeFilterProvider.select((state) => state.showAvailableOnly),
    );
    final selectedPriceBucket = ref.watch(
      bikeFilterProvider.select((state) => state.selectedPriceBucket),
    );
    final selectedRangeBucket = ref.watch(
      bikeFilterProvider.select((state) => state.selectedRangeBucket),
    );
    final hasActiveFilters = ref.watch(
      bikeFilterProvider.select((state) => state.hasActiveFilters),
    );

    return Container(
      width: 350,
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        border: Border(
          left: BorderSide(
            color: colorScheme.onSecondary.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(textTheme, colorScheme),
            const SizedBox(height: 24),
            const BikesSearchFieldWeb(),
            const SizedBox(height: 24),
            _buildDivider(colorScheme),
            const SizedBox(height: 24),
            _buildSectionTitle('Availability', textTheme, colorScheme),
            const SizedBox(height: 12),
            AvailabilityToggle(
              value: showAvailableOnly,
              onChanged: (value) =>
                  ref.read(bikeFilterProvider.notifier).setShowAvailableOnly(value),
            ),
            const SizedBox(height: 24),
            _buildDivider(colorScheme),
            const SizedBox(height: 24),
            _buildSectionTitle('Price Range', textTheme, colorScheme),
            const SizedBox(height: 12),
            PriceBucketSelector(
              selectedBucket: selectedPriceBucket,
              onChanged: (bucket) =>
                  ref.read(bikeFilterProvider.notifier).setPriceBucket(bucket),
            ),
            const SizedBox(height: 24),
            _buildDivider(colorScheme),
            const SizedBox(height: 24),
            _buildSectionTitle('Range (km)', textTheme, colorScheme),
            const SizedBox(height: 12),
            RangeBucketSelector(
              selectedBucket: selectedRangeBucket,
              onChanged: (bucket) =>
                  ref.read(bikeFilterProvider.notifier).setRangeBucket(bucket),
            ),
            const SizedBox(height: 24),
            _buildDivider(colorScheme),
            const SizedBox(height: 24),
            _buildResultsCount(bikesCount, textTheme, colorScheme),
            if (hasActiveFilters) ...[
              const SizedBox(height: 16),
              _buildResetButton(context, ref, colorScheme, textTheme),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(TextTheme textTheme, ColorScheme colorScheme) => Text(
        'Filters',
        style: textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: colorScheme.onSecondary,
        ),
      );

  Widget _buildSectionTitle(
    String title,
    TextTheme textTheme,
    ColorScheme colorScheme,
  ) =>
      Text(
        title,
        style: textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: colorScheme.onSecondary,
        ),
      );

  Widget _buildDivider(ColorScheme colorScheme) => Divider(
        color: colorScheme.onSecondary.withValues(alpha: 0.1),
        height: 1,
      );

  Widget _buildResultsCount(
    int count,
    TextTheme textTheme,
    ColorScheme colorScheme,
  ) =>
      Text(
        'Showing $count ${count == 1 ? 'bike' : 'bikes'}',
        style: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSecondary.withValues(alpha: 0.7),
        ),
      );

  Widget _buildResetButton(
    BuildContext context,
    WidgetRef ref,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) =>
      SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: () => ref.read(bikeFilterProvider.notifier).resetFilters(),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: colorScheme.primary),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          child: Text(
            'Reset filters',
            style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
}
