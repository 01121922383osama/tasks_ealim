import '../entities/usr_entities.dart';
import '../repositories/firebase_repository.dart';

class RegisterUseCases {
  final FirebaseRepository repository;
  RegisterUseCases({required this.repository});
  Future<void> call(UserEntity userEntity) async {
    await repository.register(userEntity);
  }
}
