import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../viewmodel/notifiers/filter/bike_filter_provider.dart';
import 'filter_sheet_mobile.dart';

class FilterButtonMobile extends ConsumerWidget {
  const FilterButtonMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // Calculate active filter count (excluding search since it's in a separate field)
    final activeCount = ref.watch(
      bikeFilterProvider.select((state) =>
          (state.showAvailableOnly ? 1 : 0) +
          (state.selectedPriceBucket != null ? 1 : 0) +
          (state.selectedRangeBucket != null ? 1 : 0)),
    );

    return OutlinedButton.icon(
      onPressed: () => _showFilterSheet(context),
      icon: Icon(Icons.tune, color: colorScheme.primary),
      label: Text(
        activeCount > 0 ? 'Filter ($activeCount)' : 'Filter',
        style: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSecondary,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: activeCount > 0
              ? colorScheme.primary
              : colorScheme.onSecondary.withValues(alpha: 0.3),
          width: activeCount > 0 ? 2 : 1,
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      ),
    );
  }

  void _showFilterSheet(BuildContext context) => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => const FilterSheetMobile(),
      );
}
