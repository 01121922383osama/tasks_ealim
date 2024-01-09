import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../../../Core/Utils/app_string.dart';
import '../../../../Core/Utils/media_query_value.dart';
import '../../../App/presentation/manager/Toggle/toggle_cubit.dart';
import '../../../Auth/presentation/Manager/BlocUserInfoLogin/sign_in_blocs.dart';
import '../../../Auth/presentation/Manager/BlocUserInfoLogin/sign_in_events.dart';
import '../../../Tasks/domain/entities/task_user_entie.dart';

import '../../../../Config/Routes/routs_name.dart';
import '../../../../Core/Helper/storage.dart';
import '../../../../Core/Widgets/custom_alert_dialog.dart';
import '../../../../Core/Widgets/custom_button.dart';
import '../../../Auth/presentation/Manager/Credential/credential_cubit.dart';

class LogOutWidget extends StatelessWidget {
  const LogOutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CredentialCubit, CredentialState>(
      builder: (context, state) {
        return state is! CredentialLoading
            ? CustomButton(
                text: 'Logout',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return CustomDialog(
                        text1: 'Yes',
                        text2: 'No',
                        function1: () async {
                          BlocProvider.of<CredentialCubit>(context).logout();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              AppRoutes.login, (route) => false);
                          BlocProvider.of<ToggleCubit>(context).toggle(0);
                          BlocProvider.of<SignInBloc>(context)
                              .add(const DeleteEvent());
                          await StorageService().clear();
                          Box box =
                              Hive.box<TaskUserEntiy>(AppStrings.allTaskHive);
                          if (box.isNotEmpty) {
                            await Hive.deleteFromDisk();
                          }
                        },
                        function2: () {
                          Navigator.pop(context);
                        },
                        title: 'We will miss you..🥲',
                      );
                    },
                  );
                },
                width: context.width,
                height: context.height * 0.07,
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
