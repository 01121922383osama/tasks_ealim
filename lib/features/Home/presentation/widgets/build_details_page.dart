import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_ealim/Core/Utils/app_shadow.dart';
import 'package:tasks_ealim/features/Home/presentation/widgets/edit_tasks_page.dart';

import '../../../../Core/Utils/app_colors.dart';
import '../../../../Core/Utils/media_query_value.dart';
import '../../../../Core/Widgets/custom_texts.dart';
import '../../../Tasks/domain/entities/task_user_entie.dart';
import '../../../Tasks/presentation/manager/cubit/tasks_cubit.dart';
import 'build_video_view.dart';

class DetailsPage extends StatelessWidget {
  final TaskUserEntiy taskUserEntiy;
  final int index;
  const DetailsPage(
      {super.key, required this.taskUserEntiy, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            icon: Icon(
              CupertinoIcons.pencil_ellipsis_rectangle,
              color: AppColors.white,
              shadows: shadow,
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 1,
                  child: const Row(
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 10),
                      Text('Edit'),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          EditTasksPage(taskUserEntiy: taskUserEntiy),
                    ));
                  },
                ),
                PopupMenuItem(
                  value: 2,
                  child: const Row(
                    children: [
                      Icon(CupertinoIcons.delete),
                      SizedBox(width: 10),
                      Text('Delete'),
                    ],
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Delete'),
                          content: const Text('Are you sure?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('No'),
                            ),
                            TextButton(
                              onPressed: () {
                                BlocProvider.of<TasksCubit>(context)
                                    .deleteTask(taskUserEntiy: taskUserEntiy)
                                    .then((value) async {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.green,
                                      animation:
                                          const AlwaysStoppedAnimation(1),
                                      dismissDirection:
                                          DismissDirection.startToEnd,
                                      behavior: SnackBarBehavior.floating,
                                      showCloseIcon: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      content:
                                          const Text('Deleted Successfully'),
                                    ),
                                  );
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                });
                              },
                              child: const Text('Yes'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ];
            },
          )
        ],
        title: Text(
          taskUserEntiy.tasks!,
          style: const TextStyle(
            color: Colors.white,
            shadows: [
              BoxShadow(
                color: AppColors.black,
                blurRadius: 10,
                spreadRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Chip(
              label: CustomTexts(
                text: taskUserEntiy.nameOfTask!,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 15),
            Card(
              color: Colors.grey.shade50,
              elevation: 25,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  taskUserEntiy.newTask!,
                  strutStyle: const StrutStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: AppColors.black,
                  ),
                ),
              ),
            ),
            Chip(
              avatar: const Icon(Icons.date_range),
              label: CustomTexts(
                text: taskUserEntiy.dateTime!,
                size: 15,
                color: AppColors.lightRed,
              ),
            ),
            const SizedBox(height: 10),
            taskUserEntiy.imageUrls!.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: taskUserEntiy.imageUrls!,
                    width: context.width * 0.9,
                    alignment: Alignment.center,
                    errorWidget: (context, url, error) {
                      return const SizedBox.shrink();
                    },
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: 10),
            taskUserEntiy.videoUrl!.isNotEmpty
                ? BuildVideoWidget(url: taskUserEntiy.videoUrl!)
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
