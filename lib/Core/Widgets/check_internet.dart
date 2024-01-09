import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/material.dart';
import '../Utils/app_colors.dart';
import '../Utils/media_query_value.dart';

class ChechInternetWidget extends StatelessWidget {
  final Widget child;
  const ChechInternetWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LocalConnectionNotifier(
      connectionNotificationOptions: ConnectionNotificationOptions(
        alignment: Alignment.topCenter,
        animationCurve: Curves.slowMiddle,
        height: context.height * 0.05,
        disconnectedBackgroundColor: AppColors.grey,
        borderRadius: BorderRadius.circular(25),
      ),
      child: child,
    );
  }
}
