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

    return Semantics(
      label: "Filter button",
      child: FilledButton.icon(
        onPressed: () => _showFilterSheet(context),
        icon: Icon(Icons.tune, color: colorScheme.onPrimary),
        label: Text(
          activeCount > 0 ? 'Filter ($activeCount)' : 'Filter',
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: FilledButton.styleFrom(
          backgroundColor: activeCount > 0
              ? colorScheme.primary
              : colorScheme.onSecondary,
          foregroundColor: colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
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
