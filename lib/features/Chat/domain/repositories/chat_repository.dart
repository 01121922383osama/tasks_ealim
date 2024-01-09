import '../../../Auth/domain/entities/usr_entities.dart';

abstract class ChatRepository {
  Future<List<UserEntity>> getAllUsers();
}
