import 'package:flutter/material.dart';

import '../../../../Core/Utils/app_colors.dart';
import '../../../../Core/Widgets/custom_texts.dart';

class ForgetPasswordWidget extends StatelessWidget {
  const ForgetPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: InkWell(
        onTap: () {},
        child: const CustomTexts(
          decoration: TextDecoration.underline,
          text: 'ForgotPassword',
          size: 15,
          color: AppColors.red,
        ),
      ),
    );
  }
}
