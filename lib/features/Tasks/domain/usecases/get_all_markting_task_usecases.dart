import '../entities/task_user_entie.dart';
import '../repositories/task_repository.dart';

class GetAllMarktingTaskUseCases {
  final TaskRepository taskRepository;

  GetAllMarktingTaskUseCases({required this.taskRepository});
  Future<List<TaskUserEntiy>> call( ) async {
    return await taskRepository.getAllMarktingTask(    );
  }
}
