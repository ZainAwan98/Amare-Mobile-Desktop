import 'package:amare/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AMUpperBar extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const AMUpperBar({Key? key, required this.title, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          IconButton(
            icon: Image.asset('assets/icons/icon_drawer_toggle.png'),
            iconSize: 32,
            onPressed: onPressed,
          ),
          Text(
            title,
            style: TextStyle(
              color: AppTheme.accent,
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
