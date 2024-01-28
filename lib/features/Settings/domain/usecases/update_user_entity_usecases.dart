import '../repositories/setting_repository.dart';

import '../../../Auth/domain/entities/usr_entities.dart';

class UpdateUserEntityUseCases {
  final SettingRepository settingRepository;

  UpdateUserEntityUseCases({required this.settingRepository});
  Future<void> call(UserEntity userEntity) async {
    await settingRepository.updateUserData(user: userEntity);
  }
}
