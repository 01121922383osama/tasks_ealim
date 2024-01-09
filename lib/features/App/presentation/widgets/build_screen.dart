import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Chat/presentation/pages/chat_page.dart';
import '../../../Home/presentation/pages/home_page.dart';
import '../../../Settings/presentation/pages/profile_page.dart';
import '../../../Tasks/presentation/pages/tasks_page.dart';

List<Widget> buildScreens() {
  return [
    const HomePage(),
    const TasksPage(),
    const ChatPage(),
    const ProfilePage(),
  ];
}

List<NavigationDestination> navBarsItems() {
  return [
    const NavigationDestination(
      icon: Icon(CupertinoIcons.home),
      label: "Home",
    ),
    const NavigationDestination(
      icon: Icon(CupertinoIcons.add),
      label: "Add",
    ),
    NavigationDestination(
      icon: Badge.count(
        count: 1,
        child: const Icon(CupertinoIcons.chat_bubble_fill),
      ),
      label: "Chat",
    ),
    const NavigationDestination(
      icon: Icon(CupertinoIcons.profile_circled),
      label: "Profile",
    ),
  ];
}
