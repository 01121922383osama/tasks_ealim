import 'package:flutter/material.dart';
import '../../../../Core/Services/notificationserver.dart';
import '../../../../Core/Utils/app_shadow.dart';
import '../widgets/body_all_users_page.dart';

import '../../../../Core/Widgets/check_internet.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final notification = NotificationService();

  @override
  void initState() {
    notification.firebaseNotification(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChechInternetWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Chats',
            style: TextStyle(shadows: shadow),
          ),
        ),
        body: const BodyAllUsersPage(),
      ),
    );
  }
}
