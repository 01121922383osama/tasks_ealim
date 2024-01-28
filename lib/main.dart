import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_ealim/features/Auth/presentation/Manager/ForgetPassword/foreget_password_cubit.dart';

import 'Config/Routes/app_routes.dart';
import 'Config/Routes/routs_name.dart';
import 'Core/Utils/app_colors.dart';
import 'bloc_observer.dart';
import 'features/App/presentation/manager/Toggle/toggle_cubit.dart';
import 'features/Auth/presentation/Manager/Authentication/cubit/authentication_cubit.dart';
import 'features/Auth/presentation/Manager/BlocUserInfoLogin/sign_in_blocs.dart';
import 'features/Auth/presentation/Manager/BlocUserInfoRegister/register_bloc.dart';
import 'features/Auth/presentation/Manager/Credential/credential_cubit.dart';
import 'features/Auth/presentation/Manager/Picker/pick_image_cubit.dart';
import 'features/Auth/presentation/Manager/obscure_text.dart';
import 'features/Chat/presentation/cubit/chat_cubit.dart';
import 'features/Settings/presentation/cubit/setting_cubit.dart';
import 'features/Tasks/presentation/manager/Picker/file_picker_cubit.dart';
import 'features/Tasks/presentation/manager/TaskController/controler_task_blocs.dart';
import 'features/Tasks/presentation/manager/cubit/tasks_cubit.dart';
import 'firebase_options.dart';
import 'injection_container.dart' as di;

FirebaseAnalytics analytics = FirebaseAnalytics.instance;
FirebaseAnalyticsObserver observer =
    FirebaseAnalyticsObserver(analytics: analytics);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await di.init();

  runApp(const MyApp());
  Bloc.observer = SimpleBlocObserver();
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ObscureTextLoginCubit(),
        ),
        BlocProvider(
          create: (_) => ObscureTextRegisterCubit(),
        ),
        BlocProvider(
          create: (_) => FilePickerImageCubit(),
        ),
        BlocProvider(
          create: (_) => FilePickerVideoCubit(),
        ),
        BlocProvider(
          create: (_) => FilePickerMultiImagesCubit(),
        ),
        BlocProvider(
          create: (_) => ToggleCubit(),
        ),
        BlocProvider(
          create: (_) => di.sl<CredentialCubit>(),
        ),
        BlocProvider(
          create: (_) => di.sl<AuthenticationCubit>(),
        ),
        BlocProvider(
          create: (_) => di.sl<ChatCubit>(),
        ),
        BlocProvider(
          create: (_) => di.sl<SettingCubit>(),
        ),
        BlocProvider(
          create: (_) => di.sl<TasksCubit>(),
        ),
        BlocProvider(
          create: (_) => di.sl<ForegetPasswordCubit>(),
        ),
        BlocProvider(
          create: (_) => PickImageRegisterCubit(),
        ),
        BlocProvider(
          create: (_) => RegisterBlocs(),
        ),
        BlocProvider(
          create: (_) => SignInBloc(),
        ),
        BlocProvider(
          create: (_) => ControlerTaskBloc(),
        ),
      ],
      child: MaterialApp(
        navigatorObservers: <NavigatorObserver>[observer],
        debugShowCheckedModeBanner: false,
        title: 'Task Ealim',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
          useMaterial3: true,
          fontFamily: 'Poppins',
      appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.lightRed,
          ),
        ),
        initialRoute: AppRoutes.init,
        onGenerateRoute: Routes.onGenerateRoutes,
        onUnknownRoute: Routes.undefinedRoute,
      ),
    );
  }
}
