import 'dart:io';

import '../entities/usr_entities.dart';

abstract class FirebaseRepository {
  Future<void> login(UserEntity userEntity);
  Future<void> register(UserEntity userEntity);
  Future<void> logout();
  Future<void> getCurrentUser(UserEntity userEntity);
  Future<void> sendPasswordResetEmail(String email);
  Future<String> getCurrentUserId();
  Future<String> uploadImage(File image);
}
