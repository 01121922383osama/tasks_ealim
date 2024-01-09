import '../entities/task_user_entie.dart';
import '../repositories/task_repository.dart';

class GetAllDesignTaskUseCases {
  final TaskRepository taskRepository;

  GetAllDesignTaskUseCases({required this.taskRepository});
  Future<List<TaskUserEntiy>> call( ) async {
    return await taskRepository.getAllDesignTask(    );
  }
}
