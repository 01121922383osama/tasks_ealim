import 'dart:io';

import '../repositories/task_repository.dart';

class UploadImageUsecases {
  final TaskRepository taskRepository;

  UploadImageUsecases({required this.taskRepository});
  Future<String> uploadImage({required File images}) async {
    return await taskRepository.uploadImages(images: images);
  }
}
