import 'package:flutter/material.dart';
import 'package:tasks_ealim/features/Tasks/domain/entities/task_user_entie.dart';

class EditTasksPage extends StatefulWidget {
  final TaskUserEntiy taskUserEntiy;
  const EditTasksPage({super.key, required this.taskUserEntiy});

  @override
  State<EditTasksPage> createState() => _EditTasksPageState();
}

/*
dateTime
id
imageUrls
isDone
nameOfTask
newTask
tasks
videoUrl
*/
class _EditTasksPageState extends State<EditTasksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.taskUserEntiy.tasks!),
      ),
      body: const Column(
        children: [],
      ),
    );
  }
}
