import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import '../datasources/TaskLocalDataSource/task_local_datasource.dart';
import '../datasources/TaskRemoteDataSource/task_remote_data_source.dart';
import '../../domain/entities/task_user_entie.dart';
import '../../domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource taskRemoteDataSource;
  final TaskLocalDataSource taskLocalDataSource;

  TaskRepositoryImpl({
    required this.taskRemoteDataSource,
    required this.taskLocalDataSource,
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
    List<TaskUserEntiy> localData = taskLocalDataSource.getAllTask();
    List<TaskUserEntiy> remoteData =
        await taskRemoteDataSource.getAllTask(taskNmae: taskNmae);
    log('${localData.length == remoteData.length}');
    log('LOCAL=>:${localData.length}');
    log('REMOTE=>:${remoteData.length}');
    if (localData.length == remoteData.length) {
      if (kDebugMode) {
        log('LOCAL');
      }
      return localData;
    } else {
      if (kDebugMode) {
        log('REMOTE');
      }
      return remoteData;
    }
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
    List<TaskUserEntiy> localData = taskLocalDataSource.getAllDesignTask();
    List<TaskUserEntiy> remoteData =
        await taskRemoteDataSource.getAllDesignTask();
    log('${localData.length == remoteData.length}');
    log('DESIGN:=:LOCAL=>:${localData.length}');
    log('DESIGN:=:REMOTE=>:${remoteData.length}');
    if (localData.length == remoteData.length) {
      log('LOCAL');
      return localData;
    } else {
      log('REMOTE');
      return remoteData;
    }
  }

  @override
  Future<List<TaskUserEntiy>> getAllMarktingTask() async {
    List<TaskUserEntiy> localData = taskLocalDataSource.getAllMarktingTask();
    List<TaskUserEntiy> remoteData =
        await taskRemoteDataSource.getAllMarktingTask();
    if (kDebugMode) {
      log('${localData.length == remoteData.length}');
      log('MARKTING:=:LOCAL=>:${localData.length}');
      log('MARKTING:=:REMOTE=>:${remoteData.length}');
    }
    if (localData.length == remoteData.length) {
      log('LOCAL');
      return localData;
    } else {
      log('REMOTE');
      return remoteData;
    }
  }

  @override
  Future<List<TaskUserEntiy>> getAllProgramminTask() async {
    List<TaskUserEntiy> localData = taskLocalDataSource.getAllProgramminTask();
    List<TaskUserEntiy> remoteData =
        await taskRemoteDataSource.getAllProgramminTask();
    if (kDebugMode) {
      log('${localData.length == remoteData.length}');
      log('PROGRAMMING:=:LOCAL=>:${localData.length}');
      log('PROGRAMMING:=:REMOTE=>:${remoteData.length}');
    }
    if (localData.length == remoteData.length) {
      log('LOCAL');
      return localData;
    } else {
      log('REMOTE');
      return remoteData;
    }
  }

  @override
  Future<List<TaskUserEntiy>> getAllSupportTask() async {
    List<TaskUserEntiy> localData = taskLocalDataSource.getAllSupportTask();
    List<TaskUserEntiy> remoteData =
        await taskRemoteDataSource.getAllSupportTask();
    if (kDebugMode) {
      log('${localData.length == remoteData.length}');
      log('SUPPORT:=:LOCAL=>:${localData.length}');
      log('SUPPORT:=:REMOTE=>:${remoteData.length}');
    }
    if (localData.length == remoteData.length) {
      log('LOCAL');
      return localData;
    } else {
      log('REMOTE');
      return remoteData;
    }
  }
}
