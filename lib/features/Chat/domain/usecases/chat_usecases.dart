import '../../../Auth/domain/entities/usr_entities.dart';
import '../repositories/chat_repository.dart';

class ChatUseCases {
  final ChatRepository settingRepository;

  ChatUseCases({required this.settingRepository});

  Future<List<UserEntity>> getAllUsers() async {
    return await settingRepository.getAllUsers();
  }
}
