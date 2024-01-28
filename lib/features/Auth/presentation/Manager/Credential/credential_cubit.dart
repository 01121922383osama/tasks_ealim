import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Core/Error/firebase_errors.dart';
import '../../../domain/entities/usr_entities.dart';
import '../../../domain/usecases/get_current_user_id_use_cases.dart';
import '../../../domain/usecases/get_current_user_usecases.dart';
import '../../../domain/usecases/login_use_cases_usecases.dart';
import '../../../domain/usecases/logout_use_cases_usecases.dart';
import '../../../domain/usecases/register_use_cases.dart';
import '../../../domain/usecases/uploa_image_useases.dart';

part 'credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  final LoginUseCases loginUseCases;
  final RegisterUseCases registerUseCases;
  final LogoutUseCases logoutUseCases;
  final CurrentUserIdUseCases currentUserIdUseCases;
  final GetCurrentUserUseCases getCurrentUserUseCases;
  final UploadImageUseCases uploadImage;
  CredentialCubit({
    required this.loginUseCases,
    required this.registerUseCases,
    required this.logoutUseCases,
    required this.currentUserIdUseCases,
    required this.getCurrentUserUseCases,
    required this.uploadImage,
  }) : super(CredentialInitial());
  Future<void> login(UserEntity userEntity) async {
    emit(CredentialLoading());
    try {
      await loginUseCases.call(userEntity);
      emit(CredentialISuccess());
    } on FirebaseException catch (e) {
      switch (e.code) {
        case FirebaseERROR.invalidEmail:
        case FirebaseERROR.wrongPassword:
        case FirebaseERROR.userNotFound:
        case FirebaseERROR.emailAlreadyInUse:
        case FirebaseERROR.invalidPassword:
        case FirebaseERROR.weakPassword:
        case FirebaseERROR.toomanyrequests:
        case FirebaseERROR.userDisabled:
          emit(CredentialFailure(message: e.toString()));
          break;
        default:
          emit(const CredentialFailure(
              message: 'Authentication failed. Please try again.'));
          break;
      }
    }
  }

  Future<void> register(UserEntity userEntity) async {
    emit(CredentialLoading());
    try {
      await registerUseCases.call(userEntity);
      await getCurrentUserUseCases.call(userEntity);
      // await uploadImage.call(File(image));
      emit(CredentialISuccess());
    } on FirebaseException catch (e) {
      switch (e.code) {
        case FirebaseERROR.invalidEmail:
        case FirebaseERROR.wrongPassword:
        case FirebaseERROR.userNotFound:
        case FirebaseERROR.emailAlreadyInUse:
        case FirebaseERROR.invalidPassword:
        case FirebaseERROR.weakPassword:
          emit(CredentialFailure(message: e.toString()));
        default:
          emit(const CredentialFailure(
              message: 'Authentication failed. Please try again.'));
          break;
      }
    }
  }

  Future<void> logout() async {
    try {
      await logoutUseCases.call();
    } catch (e) {
      emit(CredentialFailure(message: e.toString()));
    }
  }

  Future<void> getCurrentUserId() async {
    emit(CredentialLoading());
    try {
      await currentUserIdUseCases.call();
      emit(CredentialISuccess());
    } catch (e) {
      emit(CredentialFailure(message: e.toString()));
    }
  }

  Future<void> getCurrentUser(UserEntity userEntity) async {
    emit(CredentialLoading());
    try {
      await getCurrentUserUseCases.call(userEntity);
      emit(CredentialISuccess());
    } catch (e) {
      emit(CredentialFailure(message: e.toString()));
    }
  }
}
