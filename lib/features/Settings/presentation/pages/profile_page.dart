import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:tasks_ealim/Config/Routes/routs_name.dart';
import 'package:tasks_ealim/Core/Helper/storage.dart';
import 'package:tasks_ealim/Core/Utils/app_colors.dart';
import 'package:tasks_ealim/Core/Utils/app_shadow.dart';
import 'package:tasks_ealim/Core/Utils/app_string.dart';
import 'package:tasks_ealim/Core/Widgets/custom_alert_dialog.dart';
import 'package:tasks_ealim/features/App/presentation/manager/Toggle/toggle_cubit.dart';
import 'package:tasks_ealim/features/Auth/presentation/Manager/BlocUserInfoLogin/sign_in_blocs.dart';
import 'package:tasks_ealim/features/Auth/presentation/Manager/BlocUserInfoLogin/sign_in_events.dart';

import '../../../../Core/Widgets/check_internet.dart';
import '../../../Auth/presentation/Manager/Credential/credential_cubit.dart';
import '../../../Tasks/domain/entities/task_user_entie.dart';
import '../widgets/body_profile_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChechInternetWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile',
            style: TextStyle(shadows: shadow),
          ),
          actions: [
            IconButton(
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
              icon: Icon(
                Icons.logout,
                size: 30,
                color: AppColors.black,
                shadows: shadow,
              ),
            ),
          ],
        ),
        body: const BodyProfilePage(),
      ),
    );
  }
}
