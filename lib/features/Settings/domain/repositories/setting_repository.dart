import '../../../Auth/domain/entities/usr_entities.dart';

abstract class SettingRepository {
  Future<UserEntity> getCurrentUserData({required String id});
}
