import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../Core/Utils/app_colors.dart';
import '../../../../Core/Utils/media_query_value.dart';
import '../../../../Core/Widgets/custom_texts.dart';
import 'build_video_view.dart';
import '../../../Tasks/domain/entities/task_user_entie.dart';

class DetailsPage extends StatelessWidget {
  final TaskUserEntiy taskUserEntiy;
  const DetailsPage({super.key, required this.taskUserEntiy});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            CachedNetworkImage(
              imageUrl: taskUserEntiy.imageUrls!,
              width: context.width * 0.9,
              alignment: Alignment.center,
              errorWidget: (context, url, error) {
                return const SizedBox.shrink();
              },
            ),
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
