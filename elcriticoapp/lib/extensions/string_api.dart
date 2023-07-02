import 'dart:developer';

import 'package:flutter/material.dart';

extension ToColor on String {
  Color toColor() {
    String hex = replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    if (hex.length == 8) {
      return Color(int.parse('0x$hex'));
    }
    log('Failed to parse color: $hex. Defaulting to black');
    return Colors.black;
  }
}
