// Import necessary packages and files

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Auth/domain/entities/usr_entities.dart';
import '../../../Auth/domain/usecases/get_current_user_id_use_cases.dart';
import '../../../Auth/presentation/Manager/Authentication/cubit/authentication_cubit.dart';
import '../../domain/usecases/chat_usecases.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatUseCases chatUseCases;
  final CurrentUserIdUseCases currentUserIdUseCases;
  final AuthenticationCubit authenticationCubit;

  ChatCubit({
    required this.chatUseCases,
    required this.currentUserIdUseCases,
    required this.authenticationCubit,
  }) : super(ChatInitial());

  Future<List<UserEntity>> getAllUsers() async {
    emit(ChatLoading());
    try {
      final userId = await authenticationCubit.getCurrentUserId();
      final allUsers = await chatUseCases.getAllUsers();
      final filteredUsers =
          allUsers.where((user) => user.uuid != userId).toList();
      emit(ChatSuccess());
      return filteredUsers;
    } catch (e) {
      emit(ChatFailure(message: e.toString()));
      return [];
    }
  }
}
