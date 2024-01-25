import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Auth/domain/entities/usr_entities.dart';
import '../../../Auth/domain/usecases/get_current_user_id_use_cases.dart';
import '../../domain/usecases/get_current_userdata_usecases.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  final GetCurrentUserDataUseCases getCurrentUserDataUseCases;
  final CurrentUserIdUseCases currentUserIdUseCases;
  SettingCubit({
    required this.getCurrentUserDataUseCases,
    required this.currentUserIdUseCases,
  }) : super(SettingInitial());
  Future<UserEntity> getCurrentUserData() async {
    emit(SettingLoading());
    try {
      String uid = await currentUserIdUseCases.call();
      final userData = await getCurrentUserDataUseCases.call(id: uid);
      emit(SettingSuccess(userEntity: userData));
      return userData;
    } catch (e) {
      emit(SettingFailure(message: e.toString()));
      throw Exception();
    }
  }
}
