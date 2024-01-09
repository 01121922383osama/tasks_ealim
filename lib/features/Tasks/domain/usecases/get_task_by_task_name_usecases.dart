import '../entities/task_user_entie.dart';
import '../repositories/task_repository.dart';

class GetTaskByTaskNameUseCases {
  final TaskRepository taskRepository;

  GetTaskByTaskNameUseCases({required this.taskRepository});
  Future<TaskUserEntiy?> getTaskByTaskName({required String taskName}) async {
    return await taskRepository.getTaskByTaskName(taskName: taskName);
  }
}
