import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:hive/hive.dart';
import '../../../Tasks/domain/entities/task_user_entie.dart';

import '../../../../Config/Routes/routs_name.dart';
import '../../../../Core/Helper/storage.dart';
import '../../../../Core/Utils/app_string.dart';
import '../../../../Core/Utils/media_query_value.dart';
import '../../../../Core/Widgets/custom_button.dart';
import '../../../../Core/Widgets/custom_text_field.dart';
import '../../domain/entities/usr_entities.dart';
import '../Manager/BlocUserInfoLogin/sign_in_blocs.dart';
import '../Manager/BlocUserInfoLogin/sign_in_events.dart';
import '../Manager/BlocUserInfoLogin/sign_in_state.dart';
import '../Manager/Credential/credential_cubit.dart';
import '../Manager/obscure_text.dart';
import 'forgot_password.dart';
import 'head_login.dart';

class LoginPageBody extends StatelessWidget {
  const LoginPageBody({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: BlocBuilder<SignInBloc, SignInState>(
        builder: (context, stateSignIn) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const HeadLoginPage(),
              CustomTextField(
                onChanged: (value) {
                  BlocProvider.of<SignInBloc>(context).add(EmailEvent(value.trim()));
                },
                obscureText: false,
                text: AppStrings.email,
                prefixIcon: const Icon(Icons.email),
              ),
              BlocBuilder<ObscureTextLoginCubit, bool>(
                builder: (context, state) {
                  return CustomTextField(
                    onChanged: (value) {
                      BlocProvider.of<SignInBloc>(context)
                          .add(PasswordEvent(value.trim()));
                    },
                    prefixIcon: const Icon(Icons.lock),
                    obscureText: !state,
                    text: AppStrings.password,
                    suffixIcon: IconButton(
                      onPressed: () {
                        context.read<ObscureTextLoginCubit>().toggle();
                      },
                      icon:
                          Icon(state ? Icons.visibility : Icons.visibility_off),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              BlocListener<CredentialCubit, CredentialState>(
                listener: (context, state) {
                  if (state is CredentialLoading) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          title: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                    );
                  }
                  if (state is CredentialISuccess) {
                    Navigator.of(context).pop();
                    showToast('Login successful',
                        context: context, duration: const Duration(seconds: 3));

                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRoutes.app, (route) => false);
                    // ///////////////////
                    // for save login
                    StorageService()
                        .save(AppStrings.keyLogin, AppStrings.valueLogin);
                    // ///////////////////
                  }
                  if (state is CredentialFailure) {
                    Navigator.of(context).pop();
                    showToast('Login failed: ${state.message}',
                        context: context, duration: const Duration(seconds: 3));
                  }
                },
                child: CustomButton(
                  text: AppStrings.login,
                  fontSize: 25,
                  onPressed: () async {
                    if (stateSignIn.email.isEmpty) {
                      showToast('Please add Eamil',
                          context: context,
                          duration: const Duration(seconds: 3));
                    } else if (stateSignIn.password.isEmpty) {
                      showToast('Please add Password',
                          context: context,
                          duration: const Duration(seconds: 3));
                    } else {
                      BlocProvider.of<CredentialCubit>(context).login(
                        UserEntity(
                          email: stateSignIn.email,
                          password: stateSignIn.password,
                        ),
                      );
                      await Hive.openBox<TaskUserEntiy>(AppStrings.allTaskHive);
                      await Hive.openBox<TaskUserEntiy>(
                          AppStrings.programingHive);
                      await Hive.openBox<TaskUserEntiy>(
                          AppStrings.marktingHive);
                      await Hive.openBox<TaskUserEntiy>(AppStrings.suportHive);
                      await Hive.openBox<TaskUserEntiy>(AppStrings.designHive);
                    }
                  },
                  width: context.width * 0.9,
                  height: context.height * 0.08,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const ForgetPasswordWidget(),
            ],
          );
        },
      ),
    );
  }
}
