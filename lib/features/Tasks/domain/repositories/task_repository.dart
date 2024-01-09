import 'dart:io';

import 'package:image_picker/image_picker.dart';
import '../entities/task_user_entie.dart';

abstract class TaskRepository {
  Future<void> createTask({required TaskUserEntiy taskUserEntiy});
  Future<void> deleteTask({required TaskUserEntiy taskUserEntiy});
  Future<void> updateTask({required TaskUserEntiy taskUserEntiy});
  Future<TaskUserEntiy?> getTaskByTaskName({required String taskName});
  Future<String> uploadImages({required File images});
  Future<String> uploadVideo({required XFile video});
  Future<List<TaskUserEntiy>> getAllTask({required String taskNmae});
  Future<List<TaskUserEntiy>> getAllProgramminTask();
  Future<List<TaskUserEntiy>> getAllMarktingTask();
  Future<List<TaskUserEntiy>> getAllSupportTask();
  Future<List<TaskUserEntiy>> getAllDesignTask();
}
