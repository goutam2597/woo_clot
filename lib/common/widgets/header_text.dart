
import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  final String text;
  final double fontSize;

  const HeaderText({super.key, required this.text, this.fontSize = 14.0});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500),
    );
  }
}
