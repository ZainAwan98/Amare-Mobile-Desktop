import 'package:amare/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var offset = const Offset(32, 34);

    canvas.drawCircle(
        offset,
        50,
        Paint()
          ..color = AppTheme.accent.withOpacity(0.1)
          ..style = PaintingStyle.fill);
    canvas.drawCircle(
        offset,
        41,
        Paint()
          ..color = AppTheme.accent
          ..style = PaintingStyle.fill);
    canvas.drawCircle(
        offset,
        40,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
