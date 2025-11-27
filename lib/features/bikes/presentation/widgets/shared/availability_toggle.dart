import 'package:flutter/material.dart';

class AvailabilityToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const AvailabilityToggle({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return CheckboxListTile(
      value: value,
      onChanged: (newValue) => onChanged(newValue ?? false),
      title: Text(
        'Available only',
        style: textTheme.bodyLarge?.copyWith(
          color: colorScheme.onSecondary,
        ),
      ),
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: colorScheme.primary,
      contentPadding: EdgeInsets.zero,
    );
  }
}
