part of 'tasks_cubit.dart';

abstract class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [];
}

class TasksInitial extends TasksState {
  @override
  List<Object> get props => [];
}

class TasksLoading extends TasksState {
  @override
  List<Object> get props => [];
}

class TasksSuccess extends TasksState {
  @override
  List<Object> get props => [];
}

class TasksFailure extends TasksState {
  final String message;

  const TasksFailure({required this.message});
  @override
  List<Object> get props => [message];
}
