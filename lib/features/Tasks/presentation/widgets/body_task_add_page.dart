import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:uuid/uuid.dart';

import '../../../../Core/Utils/media_query_value.dart';
import '../../../../Core/Widgets/custom_button.dart';
import '../../../../Core/Widgets/custom_text_field.dart';
import '../../domain/entities/task_user_entie.dart';
import '../manager/Picker/file_picker_cubit.dart';
import '../manager/TaskController/controler_task_blocs.dart';
import '../manager/TaskController/controler_task_state.dart';
import '../manager/cubit/tasks_cubit.dart';
import 'file_widget.dart';

class BodyAddTasksPage extends StatelessWidget {
  final String taskName;
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController newTaskController = TextEditingController();

  BodyAddTasksPage({super.key, required this.taskName});

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      log(taskName);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: BlocBuilder<FilePickerImageCubit, FilePickerImageState>(
        builder: (context, stateImage) {
          return BlocBuilder<FilePickerVideoCubit, FilePickerVideoState>(
            builder: (context, statevideo) {
              return BlocBuilder<FilePickerMultiImagesCubit,
                  FilePickerMultiImagesState>(
                builder: (context, stateMultiImages) {
                  return BlocBuilder<ControlerTaskBloc, ControlerTaskState>(
                    builder: (context, controlerState) {
                      return BlocListener<TasksCubit, TasksState>(
                        listener: (context, state) {
                          if (state is TasksLoading) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return const AlertDialog(
                                  title: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              },
                            );
                          }
                          if (state is TasksSuccess) {
                            showToast('Created Tasks Successfully',
                                context: context,
                                duration: const Duration(seconds: 3));
                            BlocProvider.of<ControlerTaskBloc>(context)
                                .resetFields();
                            BlocProvider.of<FilePickerImageCubit>(context)
                                .deleteImage();
                            context.read<FilePickerVideoCubit>().deleteVideo();
                            Navigator.pop(context);
                            taskNameController.clear();
                            newTaskController.clear();
                          }
                          if (state is TasksFailure) {
                            showToast(state.message,
                                context: context,
                                duration: const Duration(seconds: 3));
                            Navigator.pop(context);
                          }
                        },
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              CustomTextField(
                                text: 'name of task...',
                                textEditingController: taskNameController,
                                onChanged: (value) {
                                  BlocProvider.of<ControlerTaskBloc>(context)
                                      .setTaskName(value);
                                },
                                obscureText: false,
                                prefixIcon: const Icon(CupertinoIcons.pen),
                              ),
                              CustomTextField(
                                text: 'Add new task...',
                                textEditingController: newTaskController,
                                onChanged: (value) {
                                  BlocProvider.of<ControlerTaskBloc>(context)
                                      .setNewTask(value);
                                },
                                obscureText: false,
                                maxLines: 5,
                                prefixIcon: const Icon(CupertinoIcons.pen),
                              ),
                              const FilesWidget(),
                              const SizedBox(height: 30),
                              CustomButton(
                                text: 'Add Task',
                                onPressed: () {
                                  final day = DateTime.now().day;
                                  final month = DateTime.now().month;
                                  final year = DateTime.now().year;
                                  if (controlerState.taskName.isEmpty) {
                                    showToast(
                                        'Please enter the name of the task',
                                        context: context);
                                  } else if (controlerState.newTask.isEmpty) {
                                    showToast('Please enter the new task',
                                        context: context);
                                  } else {
                                    BlocProvider.of<TasksCubit>(context)
                                        .createTask(
                                      taskUserEntiy: TaskUserEntiy(
                                        dateTime: '$day / $month / $year',
                                        id: const Uuid().v4(),
                                        imageUrls: stateImage.image.path,
                                        isDone: true,
                                        nameOfTask: controlerState.taskName,
                                        newTask: controlerState.newTask,
                                        tasks: taskName,
                                        videoUrl: statevideo.video.path,
                                      ),
                                    );
                                  }
                                },
                                width: context.width,
                                height: context.height * 0.010,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
