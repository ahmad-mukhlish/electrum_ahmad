import 'package:flutter/material.dart';

class SnackbarHelper {
  const SnackbarHelper._();

  static void showError(
    BuildContext context,
    String message, {
    Duration? duration,
    String? semanticsLabel,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;

      final content = semanticsLabel == null
          ? Text(message)
          : Semantics(label: semanticsLabel, child: Text(message));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: duration ?? Duration(seconds: 2),
          content: content,
          backgroundColor: colorScheme.error,
        ),
      );
    });
  }
}
