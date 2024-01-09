import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/usr_entities.dart';

class UserModel extends UserEntity {
  const UserModel({
    final String? uuid,
    final String? userName,
    final String? email,
    final String? password,
    final bool? isOnline,
    final String? imageUrl,
  }) : super(
          email: email,
          imageUrl: imageUrl,
          isOnline: isOnline,
          password: password,
          userName: userName,
          uuid: uuid,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uuid: json['uuid'],
      userName: json['userName'],
      email: json['email'],
      password: json['password'],
      isOnline: json['isOnline'],
      imageUrl: json['imageUrl'],
    );
  }

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
      email: snapshot.get('email'),
      imageUrl: snapshot.get('imageUrl'),
      isOnline: snapshot.get('isOnline'),
      password: snapshot.get('password'),
      userName: snapshot.get('userName'),
      uuid: snapshot.get('uuid'),
    );
  }

  Map<String, dynamic> toDocumentSnapshot() {
    return {
      'email': email,
      'imageUrl': imageUrl,
      'isOnline': isOnline,
      'password': password,
      'userName': userName,
      'uuid': uuid,
    };
  }
}
