import '../entities/usr_entities.dart';
import '../repositories/firebase_repository.dart';

class LoginUseCases {
  final FirebaseRepository repository;

  LoginUseCases({required this.repository});

  Future<void> call(UserEntity userEntity) async {
    await repository.login(userEntity);
  }
}
