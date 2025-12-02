import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/bike.dart';

class BikeCTAButton extends StatelessWidget {
  const BikeCTAButton({
    super.key,
    required this.bike,
  });

  final Bike bike;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return FilledButton.icon(
      onPressed: bike.isAvailable ? () => _handleInterestPress(context) : null,
      style: FilledButton.styleFrom(
        backgroundColor: colorScheme.onSecondary,
        foregroundColor: colorScheme.onSecondary,
        disabledBackgroundColor: colorScheme.onSecondary.withValues(alpha: 0.3),
        disabledForegroundColor: colorScheme.onSecondary.withValues(alpha: 0.5),
        padding: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      label: Text(
        bike.isAvailable ? "I'm interested to rent" : 'Not Available',
        style: (kIsWeb ? textTheme.headlineSmall : textTheme.bodyLarge)
            ?.copyWith(
          fontWeight: FontWeight.bold,
          color: colorScheme.onPrimary,
        ),
      ),
    );
  }

  //TODO @ahmad-mukhlis still need to rethink again, is adding logic here at the shared widget is wise or not?
  void _handleInterestPress(BuildContext context) {
    context.go('/bikes/${bike.id}/interest', extra: bike);
  }
}
