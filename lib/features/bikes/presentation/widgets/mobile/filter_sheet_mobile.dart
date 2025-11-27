import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../viewmodel/notifiers/filter/bike_filter_provider.dart';
import '../../viewmodel/states/price_bucket.dart';
import '../../viewmodel/states/range_bucket.dart';
import '../shared/availability_toggle.dart';
import '../shared/price_bucket_selector.dart';
import '../shared/range_bucket_selector.dart';

class FilterSheetMobile extends HookConsumerWidget {
  const FilterSheetMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final currentFilter = ref.watch(bikeFilterProvider);

    // Local state for staging filter changes
    final showAvailable = useState(currentFilter.showAvailableOnly);
    final priceBucket = useState<PriceBucket?>(currentFilter.selectedPriceBucket);
    final rangeBucket = useState<RangeBucket?>(currentFilter.selectedRangeBucket);

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, textTheme, colorScheme),
              const SizedBox(height: 24),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle('Availability', textTheme, colorScheme),
                      const SizedBox(height: 8),
                      AvailabilityToggle(
                        value: showAvailable.value,
                        onChanged: (value) => showAvailable.value = value,
                      ),
                      const SizedBox(height: 24),
                      _buildSectionTitle('Price Range', textTheme, colorScheme),
                      const SizedBox(height: 8),
                      PriceBucketSelector(
                        selectedBucket: priceBucket.value,
                        onChanged: (value) => priceBucket.value = value,
                      ),
                      const SizedBox(height: 24),
                      _buildSectionTitle('Range (km)', textTheme, colorScheme),
                      const SizedBox(height: 8),
                      RangeBucketSelector(
                        selectedBucket: rangeBucket.value,
                        onChanged: (value) => rangeBucket.value = value,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _buildActions(
                context,
                ref,
                colorScheme,
                textTheme,
                showAvailable.value,
                priceBucket.value,
                rangeBucket.value,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    TextTheme textTheme,
    ColorScheme colorScheme,
  ) =>
      Row(
        children: [
          Text(
            'Filter Bikes',
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSecondary,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: Icon(Icons.close, color: colorScheme.onSecondary),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
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

  Widget _buildActions(
    BuildContext context,
    WidgetRef ref,
    ColorScheme colorScheme,
    TextTheme textTheme,
    bool showAvailable,
    PriceBucket? priceBucket,
    RangeBucket? rangeBucket,
  ) =>
      Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                ref.read(bikeFilterProvider.notifier).resetFilters();
                Navigator.of(context).pop();
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: colorScheme.primary),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text(
                'Reset',
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: FilledButton(
              onPressed: () {
                ref.read(bikeFilterProvider.notifier).applyFilters(
                      showAvailableOnly: showAvailable,
                      priceBucket: priceBucket,
                      rangeBucket: rangeBucket,
                    );
                Navigator.of(context).pop();
              },
              style: FilledButton.styleFrom(
                backgroundColor: colorScheme.primary,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text(
                'Apply',
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      );
}
