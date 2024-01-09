import 'package:image_picker/image_picker.dart';

import '../repositories/task_repository.dart';

class UploadVieoUseCases {
  final TaskRepository taskRepository;

  UploadVieoUseCases({required this.taskRepository});

  Future<void> uploadVideo({required XFile video}) async {
    await taskRepository.uploadVideo(video: video);
  }
}
