import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/send_password_reset_email_use_cases.dart';

part 'foreget_password_state.dart';

class ForegetPasswordCubit extends Cubit<ForegetPasswordState> {
  final SendPasswordResetEmailUseCases sendPasswordResetEmailUseCases;

  ForegetPasswordCubit({required this.sendPasswordResetEmailUseCases})
      : super(ForegetPasswordInitial());
  Future<void> sendPasswordResetEmail({required String email}) async {
    emit(ForegetPasswordLoading());
    try {
      await sendPasswordResetEmailUseCases.call(email);
      emit(ForegetPasswordSuccess());
    } catch (e) {
      emit(ForegetPasswordFailure(message: e.toString()));
    }
  }
}
