import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/price_formatter.dart';
import '../../../../bikes/domain/entities/bike.dart';

class BikeSummaryCard extends StatelessWidget {
  const BikeSummaryCard({
    super.key,
    required this.bike,
  });

  final Bike bike;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(kIsWeb ? 20 : 16),
        child: Row(
          children: [
            _buildImage(colorScheme),
            SizedBox(width: kIsWeb ? 24 : 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bike.model,
                    style: (kIsWeb
                            ? textTheme.headlineSmall
                            : textTheme.titleLarge)
                        ?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSecondary,
                    ),
                  ),
                  Text(
                    _getBikeSubtitle(),
                    style: (kIsWeb ? textTheme.bodyLarge : textTheme.bodyMedium)
                        ?.copyWith(
                      color: colorScheme.tertiary,
                    ),
                  ),
                  SizedBox(height: kIsWeb ? 24 : 8),
                  Text(
                    'Range: ${bike.rangeKm} km',
                    style: (kIsWeb ? textTheme.bodyLarge : textTheme.bodyMedium)
                        ?.copyWith(
                      color: colorScheme.tertiary,
                    ),
                  ),
                  Text(
                    'from ${formatPriceToRupiahK(bike.pricePerDay)} / day',
                    style: (kIsWeb ? textTheme.bodyLarge : textTheme.bodyMedium)
                        ?.copyWith(
                      color: colorScheme.tertiary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(ColorScheme colorScheme) {
    final imageSize = kIsWeb ? 200.0 : 80.0;

    return Container(
      width: imageSize,
      height: imageSize,
      decoration: BoxDecoration(
        color: colorScheme.onPrimary.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: bike.photoUrl.isEmpty
          ? Icon(
              Icons.two_wheeler,
              size: imageSize * 0.5,
              color: colorScheme.primary,
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: bike.photoUrl,
                fit: BoxFit.cover,
                errorWidget: (_, _, _) => Icon(
                  Icons.two_wheeler,
                  size: imageSize * 0.5,
                  color: colorScheme.primary,
                ),
                progressIndicatorBuilder: (_, _, progress) => Center(
                  child: CircularProgressIndicator(
                    value: progress.progress,
                  ),
                ),
              ),
            ),
    );
  }

  String _getBikeSubtitle() {
    final modelLower = bike.model.toLowerCase();

    if (modelLower.contains('city')) {
      return 'Urban Commuter';
    } else if (modelLower.contains('cargo')) {
      return 'Heavy Duty Cargo';
    } else if (modelLower.contains('long range')) {
      return 'Long Distance Travel';
    } else if (modelLower.contains('supercharged')) {
      return 'High Performance';
    }

    return 'Electric Scooter';
  }
}
