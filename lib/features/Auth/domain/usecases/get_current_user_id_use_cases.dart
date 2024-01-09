import '../repositories/firebase_repository.dart';

class CurrentUserIdUseCases {
  final FirebaseRepository repository;
  CurrentUserIdUseCases({required this.repository});
  Future<String> call() async {
    return await repository.getCurrentUserId();
  }
}
