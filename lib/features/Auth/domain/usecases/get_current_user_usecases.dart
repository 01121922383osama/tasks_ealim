import '../entities/usr_entities.dart';
import '../repositories/firebase_repository.dart';

class GetCurrentUserUseCases {
  final FirebaseRepository repository;

  GetCurrentUserUseCases({required this.repository});
  Future<void> call(UserEntity userEntity) async {
    return await repository.getCurrentUser(userEntity);
  }
}
