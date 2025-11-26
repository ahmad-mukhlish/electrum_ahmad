import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/price_formatter.dart';
import '../../../domain/entities/bike.dart';

class BikeSpecsRow extends StatelessWidget {
  const BikeSpecsRow({
    super.key,
    required this.bike,
  });

  final Bike bike;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _buildRangeChip(context),
        _buildAvailabilityChip(context),
        _buildPriceChip(context),
      ],
    );
  }

  Widget _buildRangeChip(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return _buildSpecChip(
      context,
      icon: Icons.battery_charging_full,
      label: 'Range: ${bike.rangeKm} km',
      backgroundColor: colorScheme.primary.withValues(alpha: 0.1),
      textColor: colorScheme.primary,
    );
  }

  Widget _buildAvailabilityChip(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return _buildSpecChip(
      context,
      icon: bike.isAvailable ? Icons.check_circle : Icons.cancel,
      label: bike.isAvailable ? 'Available' : 'Not Available',
      backgroundColor: bike.isAvailable
          ? colorScheme.primary.withValues(alpha: 0.1)
          : colorScheme.error.withValues(alpha: 0.1),
      textColor: bike.isAvailable ? colorScheme.primary : colorScheme.error,
    );
  }

  Widget _buildPriceChip(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return _buildSpecChip(
      context,
      icon: Icons.payments,
      label: 'from ${formatPriceToRupiahK(bike.pricePerDay)} / day',
      backgroundColor: colorScheme.primary,
      textColor: colorScheme.onPrimary,
    );
  }

  Widget _buildSpecChip(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color backgroundColor,
    required Color textColor,
  }) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kIsWeb ? 16 : 12,
        vertical: kIsWeb ? 12 : 8,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: kIsWeb ? 20 : 16, color: textColor),
          SizedBox(width: kIsWeb ? 8 : 6),
          Text(
            label,
            style: (kIsWeb ? textTheme.bodyLarge : textTheme.bodyMedium)
                ?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
