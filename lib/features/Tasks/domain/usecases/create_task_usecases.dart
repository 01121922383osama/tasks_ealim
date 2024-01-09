import '../entities/task_user_entie.dart';
import '../repositories/task_repository.dart';

class CreateTaskUseCases {
  final TaskRepository taskRepository;

  CreateTaskUseCases({required this.taskRepository});

  Future<void> createTask({required TaskUserEntiy taskUserEntiy}) async {
    await taskRepository.createTask(taskUserEntiy: taskUserEntiy);
  }
}
