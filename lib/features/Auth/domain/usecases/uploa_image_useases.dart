import 'dart:io';

import '../repositories/firebase_repository.dart';

class UploadImageUseCases {
  final FirebaseRepository repository;

  UploadImageUseCases({required this.repository});
  Future<String> call(File file) async {
    return await repository.uploadImage(file);
  }
}
