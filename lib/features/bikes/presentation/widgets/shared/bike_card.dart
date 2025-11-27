import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/price_formatter.dart';
import '../../../domain/entities/bike.dart';

class BikeCard extends StatelessWidget {
  final Bike bike;
  final VoidCallback? onTap;

  const BikeCard({
    super.key,
    required this.bike,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      color: colorScheme.onPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildImage(colorScheme),
            _buildContent(context, colorScheme),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(ColorScheme colorScheme) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Image.network(
        bike.photoUrl,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => Container(
          color: colorScheme.secondary,
          child: Icon(
            Icons.two_wheeler,
            size: 64,
            color: colorScheme.primary,
          ),
        ),
        loadingBuilder: (_, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            color: colorScheme.secondary,
            child: Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildModel(context, colorScheme),
          const SizedBox(height: 8),
          _buildSpecs(context, colorScheme),
          const SizedBox(height: 12),
          _buildPrice(context, colorScheme),
        ],
      ),
    );
  }

  Widget _buildModel(BuildContext context, ColorScheme colorScheme) {
    final textTheme = Theme.of(context).textTheme;
    final modelStyle = kIsWeb ? textTheme.headlineSmall : textTheme.titleLarge;

    return Text(
      bike.model,
      style: modelStyle?.copyWith(
        fontWeight: FontWeight.bold,
        color: colorScheme.onSecondary,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildSpecs(BuildContext context, ColorScheme colorScheme) {
    final textTheme = Theme.of(context).textTheme;
    final specStyle = kIsWeb ? textTheme.bodyLarge : textTheme.bodyMedium;

    return Row(
      children: [
        Icon(
          Icons.battery_charging_full,
          size: kIsWeb ? 20 : 16,
          color: colorScheme.primary,
        ),
        const SizedBox(width: 4),
        Text(
          'Range: ${bike.rangeKm} km',
          style: specStyle?.copyWith(
            color: colorScheme.onSecondary.withValues(alpha: 0.8),
          ),
        ),
        const SizedBox(width: 16),
        Icon(
          bike.isAvailable ? Icons.check_circle : Icons.cancel,
          size: kIsWeb ? 20 : 16,
          color: bike.isAvailable ? colorScheme.primary : colorScheme.error,
        ),
        const SizedBox(width: 4),
        Text(
          bike.isAvailable ? 'Available' : 'Not Available',
          style: specStyle?.copyWith(
            color: bike.isAvailable ? colorScheme.primary : colorScheme.error,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildPrice(BuildContext context, ColorScheme colorScheme) {
    final textTheme = Theme.of(context).textTheme;
    final priceStyle = kIsWeb ? textTheme.headlineSmall : textTheme.titleMedium;

    return Row(
      children: [
        Text(
          'from ',
          style: (kIsWeb ? textTheme.bodyLarge : textTheme.bodyMedium)
              ?.copyWith(
            color: colorScheme.onSecondary.withValues(alpha: 0.6),
          ),
        ),
        Text(
          formatPriceToRupiahK(bike.pricePerDay),
          style: priceStyle?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.primary,
          ),
        ),
        Text(
          ' / day',
          style: (kIsWeb ? textTheme.bodyLarge : textTheme.bodyMedium)
              ?.copyWith(
            color: colorScheme.onSecondary.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}
