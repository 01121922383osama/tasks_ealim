import 'dart:io';

import '../../domain/entities/usr_entities.dart';
import '../../domain/repositories/firebase_repository.dart';
import '../datasources/Remote_Data_Source/firebase_remote_data_source.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final FirebaseRemoteDataSource firebaseRemoteDataSource;

  FirebaseRepositoryImpl({required this.firebaseRemoteDataSource});
  @override
  Future<void> getCurrentUser(UserEntity userEntity) async {
    await firebaseRemoteDataSource.getCurrentUser(userEntity);
  }

  @override
  Future<void> login(UserEntity userEntity) async {
    await firebaseRemoteDataSource.login(userEntity);
  }

  @override
  Future<void> logout() async {
    return await firebaseRemoteDataSource.logout();
  }

  @override
  Future<void> register(UserEntity userEntity) async {
    return await firebaseRemoteDataSource.register(userEntity);
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    return await firebaseRemoteDataSource.sendPasswordResetEmail(email);
  }

  @override
  Future<String> getCurrentUserId() async {
    return await firebaseRemoteDataSource.getCurrentUserId();
  }

  @override
  Future<String> uploadImage(File image) async {
    return await firebaseRemoteDataSource.uploadImage(image);
  }
}
