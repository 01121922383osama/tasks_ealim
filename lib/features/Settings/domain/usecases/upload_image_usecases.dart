import 'dart:io';

import '../repositories/setting_repository.dart';

class UploadImageUseCases {
  final SettingRepository settingRepository;

  UploadImageUseCases({required this.settingRepository});
  Future<String?> uploadImage({required File file}) async {
    return await settingRepository.uploadImage(file: file);
  }
}
