import 'package:flutter/material.dart';

import '../../../../Core/Widgets/check_internet.dart';
import '../widgets/body_task_add_page.dart';

class AddTasksPage extends StatelessWidget {
  final String? title;
  const AddTasksPage({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return ChechInternetWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title!),
        ),
        body: BodyAddTasksPage(taskName: title!),
      ),
    );
  }
}
