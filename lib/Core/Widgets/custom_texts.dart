import 'package:flutter/material.dart';
import '../Utils/app_colors.dart';

class CustomTexts extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final TextDecoration decoration;
  const CustomTexts({
    super.key,
    required this.text,
    this.size = 20,
    this.color = AppColors.black,
    this.decoration = TextDecoration.none,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.bold,
        decoration: decoration,
      ),
    );
  }
}
