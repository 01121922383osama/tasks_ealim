import '../entities/task_user_entie.dart';
import '../repositories/task_repository.dart';

class GetAllProgramminTaskUseCases {
  final TaskRepository taskRepository;

  GetAllProgramminTaskUseCases({required this.taskRepository});
  Future<List<TaskUserEntiy>> call( ) async {
    return await taskRepository.getAllProgramminTask(   );
  }
}
