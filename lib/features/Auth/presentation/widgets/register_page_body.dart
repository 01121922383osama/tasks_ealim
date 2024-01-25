import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:hive/hive.dart';
import '../../../Tasks/domain/entities/task_user_entie.dart';

import '../../../../Config/Routes/routs_name.dart';
import '../../../../Core/Helper/randome_uid.dart';
import '../../../../Core/Helper/storage.dart';
import '../../../../Core/Utils/app_string.dart';
import '../../../../Core/Utils/media_query_value.dart';
import '../../../../Core/Widgets/custom_button.dart';
import '../../../../Core/Widgets/custom_text_field.dart';
import '../../domain/entities/usr_entities.dart';
import '../Manager/BlocUserInfoRegister/register_bloc.dart';
import '../Manager/BlocUserInfoRegister/register_events.dart';
import '../Manager/BlocUserInfoRegister/register_state.dart';
import '../Manager/Credential/credential_cubit.dart';
import '../Manager/Picker/pick_image_cubit.dart';
import '../Manager/obscure_text.dart';
import 'obsecure_icon.dart';
import 'select_profile_image.dart';

class RegisterPageBody extends StatelessWidget {
  const RegisterPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: BlocBuilder<PickImageRegisterCubit, PickImageState>(
        builder: (context, stateImage) {
          log(stateImage.image.path);
          return SingleChildScrollView(
            child: BlocBuilder<RegisterBlocs, RegisterStates>(
              builder: (context, stateUserInfo) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    ProfileAvatar(stateImage: stateImage),
                    const SizedBox(height: 20),
                    CustomTextField(
                      onChanged: (value) {
                        BlocProvider.of<RegisterBlocs>(context)
                            .add(UserNameEvent(value.trim()));
                      },
                      obscureText: false,
                      text: AppStrings.name,
                      prefixIcon: const Icon(Icons.person),
                    ),
                    CustomTextField(
                      onChanged: (value) {
                        BlocProvider.of<RegisterBlocs>(context)
                            .add(EmailEvent(value.trim()));
                      },
                      obscureText: false,
                      text: AppStrings.email,
                      prefixIcon: const Icon(Icons.email),
                    ),
                    BlocBuilder<ObscureTextRegisterCubit, bool>(
                      builder: (context, state) {
                        return CustomTextField(
                          onChanged: (value) {
                            BlocProvider.of<RegisterBlocs>(context)
                                .add(PasswordEvent(value.trim()));
                          },
                          prefixIcon: const Icon(Icons.lock),
                          obscureText: !state,
                          text: AppStrings.password,
                          suffixIcon: const ObsecUreIconWIdget(),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
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
                          showToast('Registration successful',
                              context: context,
                              duration: const Duration(seconds: 3));

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
                          showToast('Registration failed: ${state.message}',
                              context: context,
                              duration: const Duration(seconds: 3));
                          if (kDebugMode) {
                            log(state.message);
                          }
                        }
                      },
                      child: CustomButton(
                        text: AppStrings.register,
                        fontSize: 25,
                        onPressed: () async {
                          if (stateUserInfo.userName.isEmpty) {
                            showToast('Please add userName',
                                context: context,
                                duration: const Duration(seconds: 3));
                          } else if (stateUserInfo.email.isEmpty) {
                            showToast('Please add email',
                                context: context,
                                duration: const Duration(seconds: 3));
                          } else if (stateUserInfo.password.isEmpty) {
                            showToast('Please add password',
                                context: context,
                                duration: const Duration(seconds: 3));
                          } else if (stateImage.image.path.isEmpty) {
                            showToast('Please add an Image',
                                context: context,
                                duration: const Duration(seconds: 3));
                          } else {
                            BlocProvider.of<CredentialCubit>(context).register(
                              UserEntity(
                                userName: stateUserInfo.userName,
                                email: stateUserInfo.email,
                                password: stateUserInfo.password,
                                uuid: RandomUID.uuid,
                                isOnline: false,
                                imageUrl: stateImage.image.path,
                              ),
                            );
                          }
                          await Hive.openBox<TaskUserEntiy>(
                              AppStrings.allTaskHive);
                          await Hive.openBox<TaskUserEntiy>(
                              AppStrings.programingHive);
                          await Hive.openBox<TaskUserEntiy>(
                              AppStrings.marktingHive);
                          await Hive.openBox<TaskUserEntiy>(
                              AppStrings.suportHive);
                          await Hive.openBox<TaskUserEntiy>(
                              AppStrings.designHive);
                        },
                        width: context.width * 0.9,
                        height: context.height * 0.08,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
