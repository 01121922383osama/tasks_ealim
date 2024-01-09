import 'package:flutter/material.dart';

import '../../../../Core/Utils/app_colors.dart';
import '../../../../Core/Utils/app_string.dart';
import '../../../../Core/Widgets/custom_texts.dart';

class HeadLoginPage extends StatelessWidget {
  const HeadLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CustomTexts(text: AppStrings.taskfiyealim),
        CustomTexts(text: AppStrings.titleLogin, color: AppColors.lightRed),
        SizedBox(height: 15),
      ],
    );
  }
}
