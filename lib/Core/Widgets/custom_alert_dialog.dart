import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String text1;
  final String text2;
  final void Function() function1;
  final void Function() function2;
  const CustomDialog({
    super.key,
    required this.text1,
    required this.text2,
    required this.function1,
    required this.function2,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: function2,
              child: Text(text2),
            ),
            TextButton(
              onPressed: function1,
              child: Text(text1),
            ),
          ],
        ),
      ],
    );
  }
}
