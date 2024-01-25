part of 'foreget_password_cubit.dart';

sealed class ForegetPasswordState extends Equatable {
  const ForegetPasswordState();

  @override
  List<Object> get props => [];
}

final class ForegetPasswordInitial extends ForegetPasswordState {
  @override
  List<Object> get props => [];
}

final class ForegetPasswordLoading extends ForegetPasswordState {
  @override
  List<Object> get props => [];
}

final class ForegetPasswordSuccess extends ForegetPasswordState {
  @override
  List<Object> get props => [];
}

final class ForegetPasswordFailure extends ForegetPasswordState {
  final String message;

  const ForegetPasswordFailure({required this.message});

  @override
  List<Object> get props => [message];
}
