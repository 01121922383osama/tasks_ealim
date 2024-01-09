import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../Config/Routes/routs_name.dart';
import '../../../../Core/Helper/storage.dart';
import '../../../../Core/Utils/app_string.dart';
import '../../../../Core/Utils/assets.dart';
import '../../../../Core/Utils/media_query_value.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Future.delayed(
          const Duration(seconds: 2),
          () async {
            bool result = await StorageService().contains(AppStrings.keyLogin);
            log(result.toString());
            if (result) {
              Future(() {
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoutes.app, (route) => false);
              });
            } else {
              Future(() {
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoutes.login, (route) => false);
              });
            }
          },
        );
      },
    );

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: context.width,
          height: context.height * 0.5,
          child: Image.asset(Assets.assetsImagesEalim),
        ),
      ),
    );
  }
}
