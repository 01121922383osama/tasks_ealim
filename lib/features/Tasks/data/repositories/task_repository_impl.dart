import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../../domain/entities/task_user_entie.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/TaskRemoteDataSource/task_remote_data_source.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource taskRemoteDataSource;

  TaskRepositoryImpl({
    required this.taskRemoteDataSource,
  });
  @override
  Future<void> createTask({required TaskUserEntiy taskUserEntiy}) async {
    await taskRemoteDataSource.createTask(taskUserEntiy: taskUserEntiy);
  }

  @override
  Future<void> deleteTask({required TaskUserEntiy taskUserEntiy}) async {
    await taskRemoteDataSource.deleteTask(taskUserEntiy: taskUserEntiy);
  }

  @override
  Future<List<TaskUserEntiy>> getAllTask({required String taskNmae}) async {
    List<TaskUserEntiy> remoteData =
        await taskRemoteDataSource.getAllTask(taskNmae: taskNmae);
    return remoteData;
  }

  @override
  Future<TaskUserEntiy?> getTaskByTaskName({required String taskName}) async {
    return await taskRemoteDataSource.getTaskByTaskName(taskName: taskName);
  }

  @override
  Future<void> updateTask({required TaskUserEntiy taskUserEntiy}) async {
    await taskRemoteDataSource.updateTask(taskUserEntiy: taskUserEntiy);
  }

  @override
  Future<String> uploadImages({required File images}) async {
    return await taskRemoteDataSource.uploadImages(images: images);
  }

  @override
  Future<String> uploadVideo({required XFile video}) async {
    return await taskRemoteDataSource.uploadVideo(video: video);
  }

  @override
  Future<List<TaskUserEntiy>> getAllDesignTask() async {
    List<TaskUserEntiy> remoteData =
        await taskRemoteDataSource.getAllDesignTask();
    return remoteData;
  }

  @override
  Future<List<TaskUserEntiy>> getAllMarktingTask() async {
    List<TaskUserEntiy> remoteData =
        await taskRemoteDataSource.getAllMarktingTask();
    return remoteData;
  }

  @override
  Future<List<TaskUserEntiy>> getAllProgramminTask() async {
    List<TaskUserEntiy> remoteData =
        await taskRemoteDataSource.getAllProgramminTask();
    return remoteData;
  }

  @override
  Future<List<TaskUserEntiy>> getAllSupportTask() async {
    List<TaskUserEntiy> remoteData =
        await taskRemoteDataSource.getAllSupportTask();
    return remoteData;
  }
}
