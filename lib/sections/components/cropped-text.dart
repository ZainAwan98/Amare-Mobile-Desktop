// ignore_for_file: file_names

import 'package:amare/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CroppedText extends StatefulWidget {
  final String text;
  final int maxChars;
  final bool canExpand;
  final double fontSize;

  const CroppedText(
      {Key? key,
      required this.text,
      this.maxChars = 120,
      this.canExpand = false,
      this.fontSize = 14})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CroppedTextState();
}

class _CroppedTextState extends State<CroppedText> {
  bool showText = false;

  String calculateText(bool show) {
    if (widget.text.isEmpty) return "[CROPPED TEXT] Invalid text";

    final finish = widget.text.length > widget.maxChars ? '...' : '';
    final needsExpanse = widget.text.length > widget.maxChars;

    return show
        ? widget.text
        : widget.text.substring(
                0, needsExpanse ? widget.maxChars : widget.text.length) +
            finish;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          calculateText(showText),
          style: TextStyle(
            color: AppTheme.accent,
            fontSize: widget.fontSize,
          ),
        ),
        AppTheme.spacerV8,
        if (widget.canExpand)
          GestureDetector(
            onTap: () {
              setState(() {
                showText = !showText;
              });
            },
            child: Text(
              !showText ? "See more" : "See less",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: AppTheme.accent,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}
