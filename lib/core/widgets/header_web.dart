import 'package:flutter/material.dart';

class HeaderWeb extends StatelessWidget {
  const HeaderWeb({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      child: Text(
        title,
        style: theme.textTheme.headlineLarge?.copyWith(
          color: theme.colorScheme.onSecondary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
