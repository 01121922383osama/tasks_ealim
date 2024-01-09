import 'package:flutter_bloc/flutter_bloc.dart';

import 'controler_task_state.dart';

class ControlerTaskBloc extends Cubit<ControlerTaskState> {
  ControlerTaskBloc() : super(const ControlerTaskState());

  void setTaskName(String taskName) {
    emit(state.copyWith(email: taskName));
  }

  void setNewTask(String newTask) {
    emit(state.copyWith(password: newTask));
  }

  void resetFields() {
    emit(const ControlerTaskState());
  }
}
