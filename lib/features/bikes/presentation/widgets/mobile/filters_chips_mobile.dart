import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../viewmodel/notifiers/filter/bike_filter_provider.dart';

class FiltersChipsMobile extends ConsumerWidget {
  const FiltersChipsMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterState = ref.watch(bikeFilterProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    if (!filterState.hasActiveFilters) {
      return const SizedBox.shrink();
    }

    final chips = <Widget>[];

    // Availability chip
    if (filterState.showAvailableOnly) {
      chips.add(
        _buildChip(
          context,
          colorScheme,
          textTheme,
          label: 'Available only',
          onDelete: () =>
              ref.read(bikeFilterProvider.notifier).setShowAvailableOnly(false),
        ),
      );
    }

    // Price bucket chip
    if (filterState.selectedPriceBucket != null) {
      chips.add(
        _buildChip(
          context,
          colorScheme,
          textTheme,
          label: 'Price: ${filterState.selectedPriceBucket!.label}',
          onDelete: () =>
              ref.read(bikeFilterProvider.notifier).setPriceBucket(null),
        ),
      );
    }

    // Range bucket chip
    if (filterState.selectedRangeBucket != null) {
      chips.add(
        _buildChip(
          context,
          colorScheme,
          textTheme,
          label: 'Range: ${filterState.selectedRangeBucket!.label}',
          onDelete: () =>
              ref.read(bikeFilterProvider.notifier).setRangeBucket(null),
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Wrap(
        spacing: 8,
        children: chips,
      ),
    );
  }

  Widget _buildChip(
    BuildContext context,
    ColorScheme colorScheme,
    TextTheme textTheme, {
    required String label,
    required VoidCallback onDelete,
  }) =>
      Chip(
        label: Text(
          label,
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        deleteIcon: Icon(
          Icons.close,
          size: 18,
          color: colorScheme.onPrimary,
        ),
        onDeleted: onDelete,
        backgroundColor: colorScheme.primary,
        side: BorderSide.none,
      );
}
