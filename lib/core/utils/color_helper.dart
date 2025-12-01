import 'package:flutter/material.dart';

//TODO @ahmad-mukhlis consider to encapsulate this into Static Helper Class
/// Convert hex string to Color
/// Supports formats: 'FFFFFF', '#FFFFFF', 'FFFFFFFF', '#FFFFFFFF'
Color hexToColor(String hexString) {
  try {
    // Remove # if present
    final hex = hexString.replaceAll('#', '').toUpperCase();

    // Validate hex string
    if (hex.isEmpty || !RegExp(r'^[0-9A-F]+$').hasMatch(hex)) {
      return Colors.white;
    }

    // Add FF for alpha if not present (6 digits)
    final fullHex = hex.length == 6 ? 'FF$hex' : hex;

    // Validate length
    if (fullHex.length != 8) {
      return Colors.white;
    }

    // Parse and return Color
    return Color(int.parse(fullHex, radix: 16));
  } catch (e) {
    // Return white for any parsing errors
    return Colors.white;
  }
}
