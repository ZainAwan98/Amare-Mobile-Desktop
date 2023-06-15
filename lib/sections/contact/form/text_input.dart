import 'package:amare/extensions/color_extension.dart';
import 'package:amare/theme/app_theme.dart';
import 'package:flutter/material.dart';

enum FieldType { email, text, number, phone}

class AMTextInput extends StatelessWidget {
  final FieldType type;
  final String label;
  final String hint;
  final TextEditingController controller;

  late final TextInputType keyboardType;

  AMTextInput({Key? key, required this.type, required this.label, required this.hint, required this.controller})
       : super(key: key) {
    switch (type) {
      case FieldType.email:
        keyboardType = TextInputType.emailAddress;
        break;
      case FieldType.text:
        keyboardType = TextInputType.text;
        break;
      case FieldType.number:
        keyboardType = TextInputType.number;
        break;
      case FieldType.phone:
        keyboardType = TextInputType.phone;
        break;
    }
  }

  @override 
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: HexColor.fromHex("#C4C4C4"),
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.accent,
          ),
        ),
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppTheme.accent,
        ),
        labelText: label,
        focusColor: Colors.red,
        hintText: hint,
      ),
    );
  }
}
