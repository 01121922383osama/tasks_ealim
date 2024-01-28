import 'dart:io';

import '../../../Auth/domain/entities/usr_entities.dart';

abstract class SettingRepository {
  Future<UserEntity> getCurrentUserData({required String id});
  Future<void> updateUserData({required UserEntity user});
  Future<String?> uploadImage({required File file});
}
