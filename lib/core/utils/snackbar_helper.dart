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
          duration: duration ?? const Duration(seconds: 2),
          content: content,
          backgroundColor: colorScheme.error,
        ),
      );
    });
  }

  static void showInfo(
    BuildContext context,
    String message, {
    Duration? duration,
    String? semanticsLabel,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;

      final content = semanticsLabel == null
          ? Text(
              message,
              style: TextStyle(color: colorScheme.onSecondary),
            )
          : Semantics(
              label: semanticsLabel,
              child: Text(
                message,
                style: TextStyle(color: colorScheme.onSecondary),
              ),
            );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: duration ?? const Duration(seconds: 2),
          content: content,
          backgroundColor: colorScheme.secondary,
        ),
      );
    });
  }

  static void showSuccess(
    BuildContext context,
    String message, {
    Duration? duration,
    String? semanticsLabel,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;

      final content = semanticsLabel == null
          ? Text(
              message,
              style: TextStyle(color: colorScheme.onPrimary),
            )
          : Semantics(
              label: semanticsLabel,
              child: Text(
                message,
                style: TextStyle(color: colorScheme.onPrimary),
              ),
            );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: duration ?? const Duration(seconds: 2),
          content: content,
          backgroundColor: colorScheme.primary,
        ),
      );
    });
  }
}
