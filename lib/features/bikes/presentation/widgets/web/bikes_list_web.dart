import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../viewmodel/notifiers/bikes_provider.dart';
import '../shared/bike_card.dart';

class BikesListWeb extends ConsumerWidget {
  const BikesListWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bikesAsync = ref.watch(bikesProvider);

    return bikesAsync.when(
      data: (bikes) {
        if (bikes.isEmpty) {
          return _buildEmptyState(context);
        }

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1400),
            child: GridView.builder(
              padding: const EdgeInsets.all(24),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _getCrossAxisCount(context),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
              ),
              itemCount: bikes.length,
              itemBuilder: (context, index) {
                final bike = bikes[index];
                return BikeCard(
                  bike: bike,
                  onTap: () => context.go('/bikes/${bike.id}'),
                );
              },
            ),
          ),
        );
      },
      loading: () => _buildLoadingState(),
      error: (error, _) {
        _showErrorSnackbar(context, error);
        return const SizedBox.shrink();
      },
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return 3;
    if (width > 768) return 2;
    return 2;
  }

  Widget _buildEmptyState(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.two_wheeler,
            size: 120,
            color: colorScheme.primary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 24),
          Text(
            'No bikes available',
            style: textTheme.headlineMedium?.copyWith(
              color: colorScheme.onSecondary.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  void _showErrorSnackbar(BuildContext context, Object error) {
    final colorScheme = Theme.of(context).colorScheme;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading bikes: $error'),
            backgroundColor: colorScheme.error,
          ),
        );
      }
    });
  }
}
