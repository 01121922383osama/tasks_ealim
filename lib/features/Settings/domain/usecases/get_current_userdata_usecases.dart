import '../../../Auth/domain/entities/usr_entities.dart';
import '../repositories/setting_repository.dart';

class GetCurrentUserDataUseCases {
  final SettingRepository settingRepository;

  GetCurrentUserDataUseCases({required this.settingRepository});

  Future<UserEntity> call({required String id}) async {
    return await settingRepository.getCurrentUserData(id: id);
  }
}
