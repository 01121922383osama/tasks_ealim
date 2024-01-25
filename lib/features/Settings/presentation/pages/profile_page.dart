import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../../../Config/Routes/routs_name.dart';
import '../../../../Core/Helper/storage.dart';
import '../../../../Core/Utils/app_colors.dart';
import '../../../../Core/Utils/app_shadow.dart';
import '../../../../Core/Utils/app_string.dart';
import '../../../../Core/Widgets/custom_alert_dialog.dart';
import '../../../App/presentation/manager/Toggle/toggle_cubit.dart';
import '../../../Auth/presentation/Manager/BlocUserInfoLogin/sign_in_blocs.dart';
import '../../../Auth/presentation/Manager/BlocUserInfoLogin/sign_in_events.dart';
import '../../../Tasks/domain/entities/task_user_entie.dart';

import '../../../../Core/Widgets/check_internet.dart';
import '../../../Auth/presentation/Manager/Credential/credential_cubit.dart';
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
                        await _deleteHiveBox(AppStrings.allTaskHive);
                        await _deleteHiveBox(AppStrings.designHive);
                        await _deleteHiveBox(AppStrings.suportHive);
                        await _deleteHiveBox(AppStrings.marktingHive);
                        await _deleteHiveBox(AppStrings.programingHive);
                      },
                      function2: () {
                        Navigator.pop(context);
                      },
                      title: 'We will miss you :\'(',
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

Future<void> _deleteHiveBox(String boxName) async {
  Box<TaskUserEntiy>? box;
  try {
    box = await Hive.openBox<TaskUserEntiy>(boxName);
    if (box.isOpen) {
      log('Box $boxName is open. Deleting...');
      await box.clear();
      await Hive.deleteBoxFromDisk(boxName);
    } else {
      log('Box $boxName is NOT open.');
    }
  } catch (e) {
    if (kDebugMode) {
      log('Error clearing or deleting Hive box $boxName: $e');
    }
  } finally {
    if (box?.isOpen == true) {
      log('Closing box $boxName...');
      await box?.close();
    }
  }
}
