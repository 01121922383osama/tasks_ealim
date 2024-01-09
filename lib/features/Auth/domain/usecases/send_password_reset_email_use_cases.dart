import '../repositories/firebase_repository.dart';

class SendPasswordResetEmailUseCases {
  final FirebaseRepository repository;
  SendPasswordResetEmailUseCases({required this.repository});
  Future<void> call(String email) async {
    await repository.sendPasswordResetEmail(email);
  }
}
