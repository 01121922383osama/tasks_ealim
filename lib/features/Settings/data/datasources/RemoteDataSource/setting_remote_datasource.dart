import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../Auth/data/models/user_model.dart';
import '../../../../Auth/domain/entities/usr_entities.dart';

import '../../../../../Core/Utils/app_string.dart';

abstract class SettingRemoteDataSource {
  Future<UserEntity> getCurrentUserData({required String id});
}

class SettingRemoteDataSourceImpl implements SettingRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  SettingRemoteDataSourceImpl({required this.firebaseFirestore});
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
}
