import 'package:flutter/material.dart';

extension HexSupportForColor on Color {
  /// Get color from hex string.
  static Color fromHexString(final String hexString) =>
      Color(int.parse(hexString.substring(1, 9), radix: 16));

  /// Convert color to hex string.
  String toHexString() => '#${value.toRadixString(16)}';
}
