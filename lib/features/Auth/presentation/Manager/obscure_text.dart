import 'package:flutter_bloc/flutter_bloc.dart';

class ObscureTextLoginCubit extends Cubit<bool> {
  ObscureTextLoginCubit() : super(false);
  void toggle() => emit(!state);
}

class ObscureTextRegisterCubit extends Cubit<bool> {
  ObscureTextRegisterCubit() : super(false);
  void toggle() => emit(!state);
}
