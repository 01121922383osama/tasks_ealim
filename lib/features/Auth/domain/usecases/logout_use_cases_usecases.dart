import '../repositories/firebase_repository.dart';

class LogoutUseCases {
  final FirebaseRepository repository;
  LogoutUseCases({required this.repository});
  Future<void> call() async {
    await repository.logout();
  }
}
