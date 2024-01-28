import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Config/Routes/routs_name.dart';
import '../../../../Core/Helper/storage.dart';
import '../../../../Core/Utils/app_colors.dart';
import '../../../../Core/Utils/app_shadow.dart';
import '../../../../Core/Widgets/check_internet.dart';
import '../../../../Core/Widgets/custom_alert_dialog.dart';
import '../../../App/presentation/manager/Toggle/toggle_cubit.dart';
import '../../../Auth/presentation/Manager/BlocUserInfoLogin/sign_in_blocs.dart';
import '../../../Auth/presentation/Manager/BlocUserInfoLogin/sign_in_events.dart';
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
