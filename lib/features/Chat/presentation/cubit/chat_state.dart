part of 'chat_cubit.dart';

sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

final class ChatInitial extends ChatState {
  @override
  List<Object> get props => [];
}

final class ChatLoading extends ChatState {
  @override
  List<Object> get props => [];
}

final class ChatSuccess extends ChatState {
  @override
  List<Object> get props => [];
}

final class ChatFailure extends ChatState {
  final String message;

  const ChatFailure({required this.message});
  @override
  List<Object> get props => [
        message,
      ];
}
