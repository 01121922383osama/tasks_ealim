import 'package:flutter/material.dart';
import '../../../../Core/Widgets/check_internet.dart';

import '../widgets/register_page_body.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ChechInternetWidget(
      child: Scaffold(
        body: Center(
          child: RegisterPageBody(),
        ),
      ),
    );
  }
}
