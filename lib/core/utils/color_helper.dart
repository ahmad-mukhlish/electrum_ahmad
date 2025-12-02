import 'package:flutter/material.dart';

class ColorHelper {
  /// Convert hex string to Color
  /// Supports formats: 'FFFFFF', '#FFFFFF', 'FFFFFFFF', '#FFFFFFFF'
  static Color fromHex(String hexString) {
    try {
      final hex = hexString.replaceAll('#', '').toUpperCase();

      if (hex.isEmpty || !RegExp(r'^[0-9A-F]+$').hasMatch(hex)) {
        return Colors.white;
      }

      final fullHex = hex.length == 6 ? 'FF$hex' : hex;

      if (fullHex.length != 8) {
        return Colors.white;
      }

      return Color(int.parse(fullHex, radix: 16));
    } catch (e) {
      return Colors.white;
    }
  }
}
