part of 'credential_cubit.dart';

sealed class CredentialState extends Equatable {
  const CredentialState();

  @override
  List<Object> get props => [];
}

final class CredentialInitial extends CredentialState {}

final class CredentialISuccess extends CredentialState {}

final class CredentialLoading extends CredentialState {}

final class CredentialFailure extends CredentialState {
  final String message;

  const CredentialFailure({required this.message});

  @override
  List<Object> get props => [message];
}
