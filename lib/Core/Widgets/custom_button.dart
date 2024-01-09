import 'package:flutter/material.dart';

import '../Utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final Color backgroundColor;
  final Color color;
  final double width;
  final double height;
  final double fontSize;

  const CustomButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.backgroundColor = AppColors.grey,
      required this.width,
      required this.height,
      this.color = AppColors.white,
      this.fontSize = 18});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 15,
        fixedSize: Size(
          width,
          height,
        ),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
