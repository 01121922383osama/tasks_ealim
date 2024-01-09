import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final TextEditingController? textEditingController;
  final void Function(String)? onChanged;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  final int maxLines;
  const CustomTextField({
    super.key,
    required this.text,
    this.onChanged,
    this.textEditingController,
    this.suffixIcon,
    required this.obscureText,
    this.prefixIcon,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        maxLines: maxLines,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onChanged: onChanged,
        controller: textEditingController,
        obscureText: text == 'Password' ? obscureText : false,
        decoration: InputDecoration(
          label: Text(text),
          hintText: text,
          prefixIcon: text.isNotEmpty ? prefixIcon : null,
          suffixIcon: text == 'Password' ? suffixIcon : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          isDense: true,
        ),
      ),
    );
  }
}
