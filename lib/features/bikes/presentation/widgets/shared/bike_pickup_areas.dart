import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BikePickupAreas extends StatelessWidget {
  const BikePickupAreas({
    super.key,
    required this.pickupAreas,
  });

  final List<String> pickupAreas;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    if (pickupAreas.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Available Pickup Areas',
          style: (kIsWeb ? textTheme.headlineSmall : textTheme.titleLarge)
              ?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSecondary,
          ),
        ),
        SizedBox(height: kIsWeb ? 16 : 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: pickupAreas.map((area) => _buildAreaChip(context, area)).toList(),
        ),
      ],
    );
  }

  Widget _buildAreaChip(BuildContext context, String area) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kIsWeb ? 16 : 12,
        vertical: kIsWeb ? 10 : 8,
      ),
      decoration: BoxDecoration(
        color: colorScheme.tertiary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colorScheme.tertiary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.location_on,
            size: kIsWeb ? 16 : 14,
            color: colorScheme.tertiary,
          ),
          SizedBox(width: kIsWeb ? 6 : 4),
          Text(
            area,
            style: (kIsWeb ? textTheme.bodyLarge : textTheme.bodyMedium)
                ?.copyWith(
              color: colorScheme.tertiary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
