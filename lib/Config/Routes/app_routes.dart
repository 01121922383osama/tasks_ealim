import 'dart:developer';

import 'package:flutter/material.dart';

import '../../features/App/presentation/pages/app.dart';
import '../../features/Auth/presentation/pages/login_page.dart';
import '../../features/Auth/presentation/pages/register_page.dart';
import '../../features/Home/presentation/pages/home_Page.dart';
import '../../features/Splash/presentation/pages/splash_page.dart';
import '../../features/Tasks/presentation/pages/add_task_page.dart';
import 'routs_name.dart';

class Routes {
  static Route? onGenerateRoutes(RouteSettings routeSettings) {
    log("Generating route for: ${routeSettings.name}");
    switch (routeSettings.name) {
      case AppRoutes.init:
        return materialPageRoute(widget: const SplashPage());
      case AppRoutes.app:
        return materialPageRoute(widget: const AppMain());
      case AppRoutes.login:
        return materialPageRoute(widget: const LoginPage());
      case AppRoutes.home:
        return materialPageRoute(widget: const HomePage());
      case AppRoutes.addtasks:
        return materialPageRoute(widget: const AddTasksPage());
      case AppRoutes.register:
        return materialPageRoute(widget: const RegisterPage());

      default:
        return undefinedRoute(routeSettings);
    }
  }

  static Route<dynamic>? undefinedRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) {
        return const Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 100),
                Text(
                  'Page not found',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ignore: unused_element
MaterialPageRoute materialPageRoute({required Widget widget}) {
  return MaterialPageRoute(builder: (context) => widget);
}
