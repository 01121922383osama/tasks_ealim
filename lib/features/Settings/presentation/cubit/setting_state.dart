part of 'setting_cubit.dart';

sealed class SettingState extends Equatable {
  final UserEntity? userEntity;
  const SettingState({this.userEntity});

  @override
  List<Object> get props => [];
}

final class SettingInitial extends SettingState {
  @override
  List<Object> get props => [];
}

final class SettingLoading extends SettingState {
  @override
  List<Object> get props => [];
}

final class SettingSuccess extends SettingState {
  const SettingSuccess({super.userEntity});
  @override
  List<Object> get props => [];
}

final class SettingFailure extends SettingState {
  final String message;

  const SettingFailure({required this.message});
  @override
  List<Object> get props => [
        message,
      ];
}
