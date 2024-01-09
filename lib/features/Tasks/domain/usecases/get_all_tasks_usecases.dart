import '../entities/task_user_entie.dart';
import '../repositories/task_repository.dart';

class GetAllTaskUseCases {
  final TaskRepository taskRepository;

  GetAllTaskUseCases({required this.taskRepository});
  Future<List<TaskUserEntiy>> getAllTask({required String taskNmae}) async {
    return await taskRepository.getAllTask(taskNmae: taskNmae);
  }
}
