import '../entities/task_user_entie.dart';
import '../repositories/task_repository.dart';

class GetAllSupportTaskUseCases {
  final TaskRepository taskRepository;

  GetAllSupportTaskUseCases({required this.taskRepository});
  Future<List<TaskUserEntiy>> call( ) async {
    return await taskRepository.getAllSupportTask(  );
  }
}
