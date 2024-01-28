import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../../../Core/Helper/randome_uid.dart';

import '../../../../../Core/Utils/app_string.dart';
import '../../../../Auth/data/models/user_model.dart';
import '../../../../Auth/domain/entities/usr_entities.dart';

abstract class SettingRemoteDataSource {
  Future<UserEntity> getCurrentUserData({required String id});
  Future<void> updateUserData({required UserEntity user});
  Future<String?> uploadImage({required File file});
}

class SettingRemoteDataSourceImpl implements SettingRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;
  SettingRemoteDataSourceImpl(
      {required this.firebaseFirestore, required this.firebaseStorage});
  @override
  Future<UserEntity> getCurrentUserData({required String id}) async {
    List<UserEntity> users = [];
    QuerySnapshot querySnapshot =
        await firebaseFirestore.collection(AppStrings.usersKey).get();
    for (var element in querySnapshot.docs) {
      users.add(UserModel.fromSnapshot(element));
    }
    return users.firstWhere((element) => element.uuid == id);
  }

  @override
  Future<void> updateUserData({required UserEntity user}) async {
    String? imageUrl;
    try {
      imageUrl = await uploadImage(file: File(user.imageUrl!));
    } catch (e) {
      log('Error uploading image: $e');
    }
    final newUser = UserModel(
      email: user.email,
      imageUrl: imageUrl ?? user.imageUrl,
      isOnline: user.isOnline,
      password: user.password,
      userName: user.userName,
      uuid: user.uuid,
    ).toDocumentSnapshot();
    await firebaseFirestore
        .collection(AppStrings.usersKey)
        .doc(user.uuid)
        .update(newUser);
  }

  @override
  Future<String?> uploadImage({required File file}) async {
    final imageTask = await firebaseStorage
        .ref(FirebaseAuth.instance.currentUser!.uid)
        .child('Image${RandomUID.uuid}.jpg')
        .putFile(file);
    return await imageTask.ref.getDownloadURL();
  }
}
