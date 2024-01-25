import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

import '../../../../../Core/Helper/randome_uid.dart';
import '../../../../../Core/Services/notificationserver.dart';
import '../../../domain/entities/usr_entities.dart';
import '../../models/user_model.dart';

abstract class FirebaseRemoteDataSource {
  Future<void> login(UserEntity userEntity);
  Future<void> register(UserEntity userEntity);
  Future<void> logout();
  Future<void> getCurrentUser(UserEntity userEntity);
  Future<void> sendPasswordResetEmail(String email);
  Future<String> getCurrentUserId();
  Future<String> uploadImage(File file);
}
/////////////////////////////////////////
/////////////////////////////////////////
/////////////////////////////////////////
/////////////////////////////////////////
/////////////////////////////////////////

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  final FirebaseChatCore _firebaseChatCore;
  final NotificationService _notificationService;
  FirebaseRemoteDataSourceImpl(
    this._auth,
    this._firestore,
    this._storage,
    this._firebaseChatCore,
    this._notificationService,
  );
  @override
  Future<void> getCurrentUser(UserEntity userEntity) async {
    final collection = _firestore.collection('Users');
    final uuid = await getCurrentUserId();
    final image = await uploadImage(File(userEntity.imageUrl!));
    final newUser = UserModel(
      email: userEntity.email,
      password: userEntity.password,
      imageUrl: image,
      isOnline: userEntity.isOnline,
      userName: userEntity.userName,
      uuid: uuid,
    ).toDocumentSnapshot();

    final userDoc = await collection.doc(uuid).get();
    if (userDoc.exists) {
      await collection.doc(uuid).update(newUser);
    } else {
      await collection.doc(uuid).set(newUser);
    }
  }

  @override
  Future<void> login(UserEntity userEntity) async {
    await _auth.signInWithEmailAndPassword(
      email: userEntity.email!,
      password: userEntity.password!,
    );
    await _notificationService.requestPermission();
    await _notificationService.getToken();
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
  }

  @override
  Future<void> register(UserEntity userEntity) async {
    final credential = await _auth.createUserWithEmailAndPassword(
        email: userEntity.email!, password: userEntity.password!);
    final image = await uploadImage(File(userEntity.imageUrl!));
    await _firebaseChatCore.createUserInFirestore(
      types.User(
        id: credential.user!.uid,
        firstName: userEntity.userName,
        imageUrl: image,
        lastSeen: 1,
      ),
    );
    await _notificationService.requestPermission();
    await _notificationService.getToken();
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<String> getCurrentUserId() async {
    return _auth.currentUser!.uid;
  }

  @override
  Future<String> uploadImage(File file) async {
    // final imageRef = _storage.ref(uid).child('Image${RandomUID.uuid}.jpg');
    // final uploadTask = imageRef.putFile(file);
    // await uploadTask.snapshot.ref.getDownloadURL();
    final uid = await getCurrentUserId();
    final imageTask = await _storage
        .ref(uid)
        .child('Image${RandomUID.uuid}.jpg')
        .putFile(file);
    return await imageTask.ref.getDownloadURL();
  }
}
