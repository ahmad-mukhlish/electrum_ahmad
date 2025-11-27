import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/utils/snackbar_helper.dart';
import '../../viewmodel/notifiers/filter/bike_filter_provider.dart';
import '../shared/bike_card.dart';
import 'filter_button_mobile.dart';
import 'filters_chips_mobile.dart';
import 'bikes_search_mobile.dart';

class BikesFiltersMobile extends ConsumerWidget {
  const BikesFiltersMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterState = ref.watch(bikeFilterProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
          child: Column(
            children: [
              const BikesSearchMobile(),
              const SizedBox(height: 12),
              const FilterButtonMobile(),
            ],
          ),
        ),
        const FiltersChipsMobile(),
        const SizedBox(height: 8),
        Expanded(child: _buildContent(context, ref, filterState)),
      ],
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref, filterState) {
    if (filterState.isLoading) {
      return _buildLoadingState();
    }

    if (filterState.error != null) {
      SnackbarHelper.showError(
        context,
        'Error loading bikes: ${filterState.error!}',
      );
      return const SizedBox.shrink();
    }

    final filteredBikes = filterState.filteredBikes;

    if (filteredBikes.isEmpty) {
      return _buildEmptyState(
        context,
        filterState.hasActiveFilters,
        onReset: () => ref.read(bikeFilterProvider.notifier).resetFilters(),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: filteredBikes.length,
      itemBuilder: (context, index) {
        final bike = filteredBikes[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: BikeCard(
            bike: bike,
            onTap: () => context.go('/bikes/${bike.id}'),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    bool hasFilters, {
    VoidCallback? onReset,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              hasFilters ? Icons.search_off : Icons.two_wheeler,
              size: 80,
              color: colorScheme.primary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              hasFilters ? 'No bikes match your search' : 'No bikes available',
              style: textTheme.titleLarge?.copyWith(
                color: colorScheme.onSecondary.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
            if (hasFilters) ...[
              const SizedBox(height: 8),
              Text(
                'Try adjusting your filters',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSecondary.withValues(alpha: 0.6),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: onReset,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: colorScheme.primary),
                ),
                child: Text(
                  'Reset filters',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() =>
      const Center(child: CircularProgressIndicator());
}
