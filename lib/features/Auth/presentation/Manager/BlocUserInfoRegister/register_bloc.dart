import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_events.dart';
import 'register_state.dart';

class RegisterBlocs extends Bloc<RegisterEvent, RegisterStates> {
  RegisterBlocs() : super(const RegisterStates()) {
    on<UserNameEvent>(_userNameEvent);
    on<EmailEvent>(_emailEvent);
    on<PasswordEvent>(_passwordEvent);
    on<RePasswordEvent>(_rePasswrodEvent);
  }
  void _userNameEvent(UserNameEvent event, Emitter<RegisterStates> emit) {
    // print(event.userNmae);
    emit(state.copyWith(userName: event.userNmae));
  }

  void _emailEvent(EmailEvent event, Emitter emit) {
    // print(event.email);
    emit(state.copyWith(email: event.email));
  }

  void _passwordEvent(PasswordEvent event, Emitter<RegisterStates> emit) {
    // print(event.password);
    emit(state.copyWith(password: event.password));
  }

  void _rePasswrodEvent(RePasswordEvent event, Emitter<RegisterStates> emit) {
    // print(event.rePassword);
    emit(state.copyWith(rePassword: event.rePassword));
  }
}
