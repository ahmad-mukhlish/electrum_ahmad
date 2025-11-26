import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../viewmodel/notifiers/bikes_provider.dart';
import '../shared/bike_card.dart';

class BikesListMobile extends ConsumerWidget {
  const BikesListMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bikesAsync = ref.watch(bikesProvider);

    return bikesAsync.when(
      data: (bikes) {
        if (bikes.isEmpty) {
          return _buildEmptyState(context);
        }

        return ListView.builder(
          padding: const EdgeInsets.all(24),
          itemCount: bikes.length,
          itemBuilder: (context, index) {
            final bike = bikes[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: BikeCard(
                bike: bike,
                onTap: () => context.go('/bikes/${bike.id}'),
              ),
            );
          },
        );
      },
      loading: () => _buildLoadingState(),
      error: (error, _) {
        _showErrorSnackbar(context, error);
        return const SizedBox.shrink();
      },
    );
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
            size: 80,
            color: colorScheme.primary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No bikes available',
            style: textTheme.titleLarge?.copyWith(
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
