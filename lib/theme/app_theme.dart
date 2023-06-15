import 'package:flutter/material.dart';

import '../extensions/color_extension.dart';

class AppTheme {
  static Color accent = HexColor.fromHex('#012B45');
  static Color activeColor = HexColor.fromHex("#C4C4C4");

  static const spacerV8 = SizedBox(height: 8);
  static const spacerV10 = SizedBox(height: 10);
  static const spacerV12 = SizedBox(height: 12);
  static const spacerV24 = SizedBox(height: 24);
  static const spacerV32 = SizedBox(height: 32);

  static const spacerH8 = SizedBox(width: 8);
  static const spacerH10 = SizedBox(width: 10);
  static const spacerH12 = SizedBox(width: 12);
  static const spacerH24 = SizedBox(width: 24);
}
