import 'package:flutter/material.dart';
import 'package:amare/sections/home/home_screen.dart';

import 'package:amare/theme/app_theme.dart';

class SplashScreen extends StatelessWidget {
  static String routerName = 'SplashScreen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.popAndPushNamed(context, HomeScreen.routerName);
    });

    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;

          return Stack(
            children: [
              Image.asset(
                'assets/images/bg_splash.png',
                width: screenWidth,
                height: screenHeight,
                fit: BoxFit.cover,
              ),
              Center(
                child: Image.asset(
                  'assets/images/logo_amare.png',
                  color: AppTheme.accent,
                  height: screenWidth < 600 ? 68 : 136,
                  width: screenWidth < 600 ? 246 : 492,
                ),
              ),
            ],
          );
        },
      ),
      backgroundColor: AppTheme.accent,
    );
  }
}
