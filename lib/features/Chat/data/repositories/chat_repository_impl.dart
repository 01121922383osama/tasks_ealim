import '../../../Auth/domain/entities/usr_entities.dart';
import '../datasources/RemoteDataSource/chat_remote_data_source.dart';
import '../../domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource settingRemoteDataSource;

  ChatRepositoryImpl({required this.settingRemoteDataSource});
  @override
  Future<List<UserEntity>> getAllUsers() async {
    return await settingRemoteDataSource.getAllUsers();
  }
}
