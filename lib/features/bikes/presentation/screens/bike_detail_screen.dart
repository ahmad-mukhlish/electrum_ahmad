import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../viewmodel/notifiers/detail/bike_detail_provider.dart';
import '../widgets/mobile/bike_detail_content_mobile.dart';
import '../widgets/web/bike_detail_content_web.dart';

class BikeDetailScreen extends ConsumerWidget {
  const BikeDetailScreen({
    super.key,
    required this.bikeId,
  });

  /// Bike ID received from route parameter
  final String bikeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final bikeAsync = ref.watch(bikeDetailProvider(bikeId));

    return Scaffold(
      backgroundColor: colorScheme.onPrimary,
      body: bikeAsync.when(
        data: (bike) {
          if (bike == null) {
            return _buildNotFoundState(context);
          }
          return Column(
            children: [
              Expanded(
                child: kIsWeb
                    ? BikeDetailContentWeb(bike: bike)
                    : BikeDetailContentMobile(bike: bike),
              ),
            ],
          );
        },
        loading: () => _buildLoadingState(),
        error: (error, _) => _buildErrorState(context, ref, error),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildNotFoundState(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: kIsWeb ? 80 : 60,
            color: colorScheme.error,
          ),
          SizedBox(height: kIsWeb ? 24 : 16),
          Text(
            'Bike not found',
            style: (kIsWeb ? textTheme.headlineSmall : textTheme.titleLarge)
                ?.copyWith(color: colorScheme.onSecondary),
          ),
          SizedBox(height: kIsWeb ? 16 : 12),
          FilledButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back),
            label: const Text('Back to bikes'),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, WidgetRef ref, Object error) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(kIsWeb ? 32 : 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: kIsWeb ? 80 : 60,
              color: colorScheme.error,
            ),
            SizedBox(height: kIsWeb ? 24 : 16),
            Text(
              'Error loading bike details',
              style: (kIsWeb ? textTheme.headlineSmall : textTheme.titleLarge)
                  ?.copyWith(color: colorScheme.onSecondary),
            ),
            SizedBox(height: kIsWeb ? 12 : 8),
            Text(
              error.toString(),
              style: (kIsWeb ? textTheme.bodyLarge : textTheme.bodyMedium)
                  ?.copyWith(
                color: colorScheme.onSecondary.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: kIsWeb ? 24 : 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Back'),
                ),
                const SizedBox(width: 12),
                FilledButton.icon(
                  onPressed: () => ref.invalidate(bikeDetailProvider(bikeId)),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
