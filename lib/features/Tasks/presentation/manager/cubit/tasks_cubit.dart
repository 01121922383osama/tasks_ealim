import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/entities/task_user_entie.dart';
import '../../../domain/usecases/create_task_usecases.dart';
import '../../../domain/usecases/delete_task_usecases.dart';
import '../../../domain/usecases/get_all_design_task_usecases.dart';
import '../../../domain/usecases/get_all_markting_task_usecases.dart';
import '../../../domain/usecases/get_all_programming_task_usecases.dart';
import '../../../domain/usecases/get_all_support_task_usecases.dart';
import '../../../domain/usecases/get_all_tasks_usecases.dart';
import '../../../domain/usecases/get_task_by_task_name_usecases.dart';
import '../../../domain/usecases/update_task_usecases.dart';
import '../../../domain/usecases/upload_vide_usecases.dart';
import '../../../domain/usecases/uploade_images_usecase.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  final CreateTaskUseCases createTaskUseCases;
  final DeleteTaskUseCases deleteTaskUseCases;
  final GetAllTaskUseCases getAllTaskUseCases;
  final GetTaskByTaskNameUseCases getTaskByTaskNameUseCases;
  final UpdateTaskUseCases updateTaskUseCases;
  final UploadImageUsecases uploadImageUsecases;
  final UploadVieoUseCases uploadVieoUseCases;
  final GetAllProgramminTaskUseCases getAllProgramminTaskUseCases;
  final GetAllMarktingTaskUseCases getAllMarktingTaskUseCases;
  final GetAllSupportTaskUseCases getAllSupportTaskUseCases;
  final GetAllDesignTaskUseCases getAllDesignTaskUseCases;
  TasksCubit({
    required this.createTaskUseCases,
    required this.deleteTaskUseCases,
    required this.getAllTaskUseCases,
    required this.getTaskByTaskNameUseCases,
    required this.updateTaskUseCases,
    required this.uploadImageUsecases,
    required this.uploadVieoUseCases,
    required this.getAllDesignTaskUseCases,
    required this.getAllMarktingTaskUseCases,
    required this.getAllProgramminTaskUseCases,
    required this.getAllSupportTaskUseCases,
  }) : super(TasksInitial());
  Future<void> createTask({required TaskUserEntiy taskUserEntiy}) async {
    emit(TasksLoading());
    try {
      await createTaskUseCases.createTask(taskUserEntiy: taskUserEntiy);
      emit(TasksSuccess());
    } catch (e) {
      emit(TasksFailure(message: e.toString()));
    }
  }

  Future<void> updateTask({required TaskUserEntiy taskUserEntiy}) async {
    emit(TasksLoading());
    try {
      await updateTaskUseCases.updateTask(taskUserEntiy: taskUserEntiy);
      emit(TasksSuccess());
    } catch (e) {
      emit(TasksFailure(message: e.toString()));
    }
  }

  Future<void> deleteTask({required TaskUserEntiy taskUserEntiy}) async {
    emit(TasksLoading());
    try {
      await deleteTaskUseCases.deleteTask(taskUserEntiy: taskUserEntiy);
      emit(TasksSuccess());
    } catch (e) {
      emit(TasksFailure(message: e.toString()));
    }
  }

  Future<List<TaskUserEntiy>> getAllTask({required String taskName}) async {
    emit(TasksLoading());
    try {
      final userData = await getAllTaskUseCases.getAllTask(taskNmae: taskName);
      emit(TasksSuccess());
      return userData;
    } catch (e) {
      emit(TasksFailure(message: e.toString()));
      return [];
    }
  }

  Future<List<TaskUserEntiy>> getAllProgrammingTask() async {
    emit(TasksLoading());
    try {
      final userData = await getAllProgramminTaskUseCases.call();
      emit(TasksSuccess());
      return userData;
    } catch (e) {
      emit(TasksFailure(message: e.toString()));
      return [];
    }
  }

  Future<List<TaskUserEntiy>> getAllMarktingTask() async {
    emit(TasksLoading());
    try {
      final userData = await getAllMarktingTaskUseCases.call();
      emit(TasksSuccess());
      return userData;
    } catch (e) {
      emit(TasksFailure(message: e.toString()));
      return [];
    }
  }

  Future<List<TaskUserEntiy>> getAllSupportTask() async {
    emit(TasksLoading());
    try {
      final userData = await getAllSupportTaskUseCases.call();
      emit(TasksSuccess());
      return userData;
    } catch (e) {
      emit(TasksFailure(message: e.toString()));
      return [];
    }
  }

  Future<List<TaskUserEntiy>> getAllDesignTask() async {
    emit(TasksLoading());
    try {
      final userData = await getAllDesignTaskUseCases.call();
      emit(TasksSuccess());
      return userData;
    } catch (e) {
      emit(TasksFailure(message: e.toString()));
      return [];
    }
  }

  Future<void> getTaskByTaskName({required String taskName}) async {
    emit(TasksLoading());
    try {
      await getTaskByTaskNameUseCases.getTaskByTaskName(taskName: taskName);
      emit(TasksSuccess());
    } catch (e) {
      emit(TasksFailure(message: e.toString()));
    }
  }

  Future<void> uploadImage({required File images}) async {
    emit(TasksLoading());
    try {
      await uploadImageUsecases.uploadImage(images: images);
      emit(TasksSuccess());
    } catch (e) {
      emit(TasksFailure(message: e.toString()));
    }
  }

  Future<void> uploadVieo({required XFile video}) async {
    emit(TasksLoading());
    try {
      await uploadVieoUseCases.uploadVideo(video: video);
      emit(TasksSuccess());
    } catch (e) {
      emit(TasksFailure(message: e.toString()));
    }
  }
}
