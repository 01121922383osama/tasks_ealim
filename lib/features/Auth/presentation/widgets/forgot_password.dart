import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import '../../../../Core/Utils/media_query_value.dart';
import '../../../../Core/Widgets/custom_button.dart';
import '../../../../Core/Widgets/custom_text_field.dart';
import '../Manager/ForgetPassword/foreget_password_cubit.dart';

import '../../../../Core/Utils/app_colors.dart';
import '../../../../Core/Widgets/custom_texts.dart';

class ForgetPasswordWidget extends StatelessWidget {
  const ForgetPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ForgetPasswordPAGE(),
          ));
        },
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

class ForgetPasswordPAGE extends StatelessWidget {
  ForgetPasswordPAGE({super.key});
  final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: BlocListener<ForegetPasswordCubit, ForegetPasswordState>(
            listener: (context, state) {
              if (state is ForegetPasswordLoading) {
                showGeneralDialog(
                  context: context,
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              }
              if (state is ForegetPasswordSuccess) {
                Navigator.of(context).popUntil((route) => route.isFirst);
                showToast(
                    'Sending email Successfully Please check your Gmail..!',
                    context: context);
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                  text: 'Email',
                  obscureText: false,
                  textEditingController: textEditingController,
                  prefixIcon: const Icon(Icons.email),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  text: 'Submit',
                  onPressed: () {
                    if (textEditingController.text.isNotEmpty) {
                      BlocProvider.of<ForegetPasswordCubit>(context)
                          .sendPasswordResetEmail(
                              email: textEditingController.text.trim());
                    } else {
                      showToast('Please enter your email address',
                          context: context);
                    }
                  },
                  width: context.width * 0.6,
                  height: context.height * 0.01,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
