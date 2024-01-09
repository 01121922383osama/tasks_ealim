import 'package:flutter/material.dart';
import '../../../../Core/Widgets/check_internet.dart';
import '../../../../Config/Routes/routs_name.dart';
import '../../../../Core/Utils/app_colors.dart';
import '../../../../Core/Widgets/custom_texts.dart';

import '../widgets/login_page_body.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChechInternetWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: const LoginPageBody(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.register);
          },
          elevation: 25,
          splashColor: AppColors.lightRed,
          label: const CustomTexts(text: 'Register'),
        ),
      ),
    );
  }
}
