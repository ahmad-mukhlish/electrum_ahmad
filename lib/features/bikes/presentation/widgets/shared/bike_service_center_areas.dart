import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BikeServiceCenterAreas extends StatelessWidget {
  const BikeServiceCenterAreas({super.key, required this.serviceCenterAreas});

  final List<String> serviceCenterAreas;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final titleStyle = (kIsWeb ? textTheme.headlineSmall : textTheme.titleLarge)
        ?.copyWith(
          fontWeight: FontWeight.w500,
          color: colorScheme.onSecondary,
        );
    final spacing = kIsWeb ? 16.0 : 12.0;

    if (serviceCenterAreas.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Available Service Center Areas',
          style: titleStyle,
        ),
        SizedBox(height: spacing),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: serviceCenterAreas
              .map((area) => _buildAreaChip(context, area))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildAreaChip(BuildContext context, String area) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final padding = EdgeInsets.symmetric(
      horizontal: kIsWeb ? 16 : 12,
      vertical: kIsWeb ? 10 : 8,
    );
    final chipColor = colorScheme.tertiary.withValues(alpha: 0.1);
    final chipBorderColor = colorScheme.tertiary.withValues(alpha: 0.3);
    final iconSize = kIsWeb ? 16.0 : 14.0;
    final gap = kIsWeb ? 6.0 : 4.0;
    final textStyle = (kIsWeb ? textTheme.bodyLarge : textTheme.bodyMedium)
        ?.copyWith(
          color: colorScheme.tertiary,
          fontWeight: FontWeight.w600,
        );

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: chipBorderColor,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.location_on,
            size: iconSize,
            color: colorScheme.tertiary,
          ),
          SizedBox(width: gap),
          Text(
            area,
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
