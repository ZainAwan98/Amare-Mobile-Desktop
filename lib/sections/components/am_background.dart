import 'package:flutter/material.dart';

enum Background {
  player,
  podcasts,
  contact,
}

class AMBackground extends StatelessWidget {
  const AMBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Image.asset(
        'assets/images/bg_leaves_1.png',
        fit: BoxFit.fill,
      ),
    );
  }
}
