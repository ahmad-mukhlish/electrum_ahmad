import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/utils/snackbar_helper.dart';
import '../../viewmodel/notifiers/filter/bike_filter_provider.dart';
import '../shared/bike_card.dart';
import 'filter_panel_web.dart';

class BikesFiltersWeb extends ConsumerWidget {
  const BikesFiltersWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildBikesGrid(context, ref)),
        const FilterPanelWeb(),
      ],
    );
  }

  Widget _buildBikesGrid(BuildContext context, WidgetRef ref) {
    final filterState = ref.watch(bikeFilterProvider);

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

    return Center(
      child: Semantics(
        label: "Bike section",
        child: GridView.builder(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 24),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _getCrossAxisCount(context),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.85,
          ),
          itemCount: filteredBikes.length,
          itemBuilder: (context, index) {
            final bike = filteredBikes[index];
            return BikeCard(
              bike: bike,
              onTap: () => context.go('/bikes/${bike.id}'),
            );
          },
        ),
      ),
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 350;
    if (width > 1200) return 3;
    if (width > 768) return 2;
    return 2;
  }

  Widget _buildEmptyState(
    BuildContext context,
    bool hasFilters, {
    VoidCallback? onReset,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      label: "Bike empty",
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(48),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                hasFilters ? Icons.search_off : Icons.two_wheeler,
                size: 120,
                color: colorScheme.primary.withValues(alpha: 0.5),
              ),
              const SizedBox(height: 24),
              Text(
                hasFilters
                    ? 'No bikes match your search'
                    : 'No bikes available',
                style: textTheme.headlineMedium?.copyWith(
                  color: colorScheme.onSecondary.withValues(alpha: 0.7),
                ),
              ),
              if (hasFilters) ...[
                const SizedBox(height: 12),
                Text(
                  'Try adjusting your filters',
                  style: textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSecondary.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: 24),
                Semantics(
                  label: "Empty reset",
                  child: OutlinedButton(
                    onPressed: onReset,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: colorScheme.primary),
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 32,
                      ),
                    ),
                    child: Text(
                      'Reset filters',
                      style: textTheme.bodyLarge?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() => const Center(
        child: CircularProgressIndicator(),
      );
}
