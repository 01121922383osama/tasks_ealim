import '../../../Auth/domain/entities/usr_entities.dart';
import '../../domain/repositories/setting_repository.dart';
import '../datasources/RemoteDataSource/setting_remote_datasource.dart';

class SettingRepositoryImpl implements SettingRepository {
  final SettingRemoteDataSource settingRemoteDataSource;

  SettingRepositoryImpl({required this.settingRemoteDataSource});
  @override
  Future<UserEntity> getCurrentUserData({required String id}) async {
    return await settingRemoteDataSource.getCurrentUserData(id: id);
  }
}
