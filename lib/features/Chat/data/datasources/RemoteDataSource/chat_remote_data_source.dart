import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../Core/Utils/app_string.dart';
import '../../../../Auth/data/models/user_model.dart';
import '../../../../Auth/domain/entities/usr_entities.dart';

abstract class ChatRemoteDataSource {
  Future<List<UserEntity>> getAllUsers();
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;

  ChatRemoteDataSourceImpl({required this.firebaseFirestore});

  @override
  Future<List<UserEntity>> getAllUsers() async {
    try {
      final QuerySnapshot userSnapshot =
          await firebaseFirestore.collection(AppStrings.usersKey).get();

      List<UserEntity> users = userSnapshot.docs
          .map((DocumentSnapshot document) =>
              UserModel.fromJson(document.data() as Map<String, dynamic>))
          .toList();

      return users;
    } catch (e) {
      // Handle errors as needed
      log('Error fetching users: $e');
      throw Exception('Error fetching users: $e');
    }
  }
}
