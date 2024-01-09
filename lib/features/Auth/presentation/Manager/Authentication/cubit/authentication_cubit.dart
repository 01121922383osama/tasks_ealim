import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/get_current_user_id_use_cases.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final CurrentUserIdUseCases currentUserIdUseCases;

  AuthenticationCubit({
    required this.currentUserIdUseCases,
  }) : super(AuthenticationInitial());
  Future<String> getCurrentUserId() async {
    emit(AuthenticationLoading());
    try {
      final currentUserId = await currentUserIdUseCases.call();
      emit(AuthenticationSuccess(currentUserId));
      return currentUserId;
    } catch (e) {
      emit(AuthenticationFailure(message: e.toString()));
      return '';
    }
  }
}
