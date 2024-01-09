import '../entities/task_user_entie.dart';
import '../repositories/task_repository.dart';

class DeleteTaskUseCases {
  final TaskRepository taskRepository;

  DeleteTaskUseCases({required this.taskRepository});

  Future<void> deleteTask({required TaskUserEntiy taskUserEntiy}) async {
    await taskRepository.deleteTask(taskUserEntiy: taskUserEntiy);
  }
}
