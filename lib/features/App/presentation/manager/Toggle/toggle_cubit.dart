import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'toggle_state.dart';

class ToggleCubit extends Cubit<ToggleState> {
  ToggleCubit() : super(const ToggleInitial(index: 0));
  void toggle(int index) => emit(
        ToggleInitial(index: index),
      );
}
