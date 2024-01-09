import '../entities/task_user_entie.dart';
import '../repositories/task_repository.dart';

class UpdateTaskUseCases {
  final TaskRepository taskRepository;

  UpdateTaskUseCases({required this.taskRepository});
  Future<void> updateTask({required TaskUserEntiy taskUserEntiy}) async {
    await taskRepository.updateTask(taskUserEntiy: taskUserEntiy);
  }
}
