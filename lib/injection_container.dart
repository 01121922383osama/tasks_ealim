import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get_it/get_it.dart';
import 'package:tasks_ealim/Core/Services/notificationserver.dart';

import 'features/Auth/data/datasources/Remote_Data_Source/firebase_remote_data_source.dart';
import 'features/Auth/data/repositories/firebase_repository_impl.dart';
import 'features/Auth/domain/repositories/firebase_repository.dart';
import 'features/Auth/domain/usecases/get_current_user_id_use_cases.dart';
import 'features/Auth/domain/usecases/get_current_user_usecases.dart';
import 'features/Auth/domain/usecases/login_use_cases_usecases.dart';
import 'features/Auth/domain/usecases/logout_use_cases_usecases.dart';
import 'features/Auth/domain/usecases/register_use_cases.dart';
import 'features/Auth/domain/usecases/send_password_reset_email_use_cases.dart';
import 'features/Auth/domain/usecases/uploa_image_useases.dart';
import 'features/Auth/presentation/Manager/Authentication/cubit/authentication_cubit.dart';
import 'features/Auth/presentation/Manager/Credential/credential_cubit.dart';
import 'features/Chat/data/datasources/RemoteDataSource/chat_remote_data_source.dart';
import 'features/Chat/data/repositories/chat_repository_impl.dart';
import 'features/Chat/domain/repositories/chat_repository.dart';
import 'features/Chat/domain/usecases/chat_usecases.dart';
import 'features/Chat/presentation/cubit/chat_cubit.dart';
import 'features/Settings/data/datasources/RemoteDataSource/setting_remote_datasource.dart';
import 'features/Settings/data/repositories/setting_repository_impl.dart';
import 'features/Settings/domain/repositories/setting_repository.dart';
import 'features/Settings/domain/usecases/get_current_userdata_usecases.dart';
import 'features/Settings/presentation/cubit/setting_cubit.dart';
import 'features/Tasks/data/datasources/TaskLocalDataSource/task_local_datasource.dart';
import 'features/Tasks/data/datasources/TaskRemoteDataSource/task_remote_data_source.dart';
import 'features/Tasks/data/repositories/task_repository_impl.dart';
import 'features/Tasks/domain/repositories/task_repository.dart';
import 'features/Tasks/domain/usecases/create_task_usecases.dart';
import 'features/Tasks/domain/usecases/delete_task_usecases.dart';
import 'features/Tasks/domain/usecases/get_all_design_task_usecases.dart';
import 'features/Tasks/domain/usecases/get_all_markting_task_usecases.dart';
import 'features/Tasks/domain/usecases/get_all_programming_task_usecases.dart';
import 'features/Tasks/domain/usecases/get_all_support_task_usecases.dart';
import 'features/Tasks/domain/usecases/get_all_tasks_usecases.dart';
import 'features/Tasks/domain/usecases/get_task_by_task_name_usecases.dart';
import 'features/Tasks/domain/usecases/update_task_usecases.dart';
import 'features/Tasks/domain/usecases/upload_vide_usecases.dart';
import 'features/Tasks/domain/usecases/uploade_images_usecase.dart';
import 'features/Tasks/presentation/manager/cubit/tasks_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // bloc

  sl.registerFactory<CredentialCubit>(
    () => CredentialCubit(
      loginUseCases: sl.call(),
      registerUseCases: sl.call(),
      sendPasswordResetEmailUseCases: sl.call(),
      logoutUseCases: sl.call(),
      currentUserIdUseCases: sl.call(),
      getCurrentUserUseCases: sl.call(),
      uploadImage: sl.call(),
    ),
  );

  // ////////////////
  sl.registerFactory<AuthenticationCubit>(
      () => AuthenticationCubit(currentUserIdUseCases: sl.call()));
  // ///////////////
  sl.registerFactory<ChatCubit>(() => ChatCubit(
        chatUseCases: sl.call(),
        currentUserIdUseCases: sl.call(),
        authenticationCubit: sl.call(),
      ));
  // ///////////////
  sl.registerFactory<TasksCubit>(() => TasksCubit(
        createTaskUseCases: sl.call(),
        deleteTaskUseCases: sl.call(),
        getAllTaskUseCases: sl.call(),
        getTaskByTaskNameUseCases: sl.call(),
        updateTaskUseCases: sl.call(),
        uploadImageUsecases: sl.call(),
        uploadVieoUseCases: sl.call(),
        getAllDesignTaskUseCases: sl.call(),
        getAllMarktingTaskUseCases: sl.call(),
        getAllProgramminTaskUseCases: sl.call(),
        getAllSupportTaskUseCases: sl.call(),
      ));

// //////////////////
  sl.registerLazySingleton<SettingCubit>(() => SettingCubit(
        getCurrentUserDataUseCases: sl.call(),
        currentUserIdUseCases: sl.call(),
      ));

  // usecases
  sl.registerLazySingleton<GetCurrentUserUseCases>(
      () => GetCurrentUserUseCases(repository: sl.call()));
  sl.registerLazySingleton<LoginUseCases>(
      () => LoginUseCases(repository: sl.call()));
  sl.registerLazySingleton<LogoutUseCases>(
      () => LogoutUseCases(repository: sl.call()));
  sl.registerLazySingleton<SendPasswordResetEmailUseCases>(
      () => SendPasswordResetEmailUseCases(repository: sl.call()));
  sl.registerLazySingleton<RegisterUseCases>(
      () => RegisterUseCases(repository: sl.call()));
  sl.registerLazySingleton<CurrentUserIdUseCases>(
      () => CurrentUserIdUseCases(repository: sl.call()));
  sl.registerLazySingleton<UploadImageUseCases>(
      () => UploadImageUseCases(repository: sl.call()));
  sl.registerLazySingleton<ChatUseCases>(
      () => ChatUseCases(settingRepository: sl.call()));
  sl.registerLazySingleton<GetCurrentUserDataUseCases>(
      () => GetCurrentUserDataUseCases(settingRepository: sl.call()));
  // ////////////////////////////////////////
  sl.registerLazySingleton<GetTaskByTaskNameUseCases>(
      () => GetTaskByTaskNameUseCases(taskRepository: sl.call()));
  sl.registerLazySingleton<GetAllTaskUseCases>(
      () => GetAllTaskUseCases(taskRepository: sl.call()));
  sl.registerLazySingleton<CreateTaskUseCases>(
      () => CreateTaskUseCases(taskRepository: sl.call()));
  sl.registerLazySingleton<DeleteTaskUseCases>(
      () => DeleteTaskUseCases(taskRepository: sl.call()));
  sl.registerLazySingleton<UpdateTaskUseCases>(
      () => UpdateTaskUseCases(taskRepository: sl.call()));
  sl.registerLazySingleton<UploadVieoUseCases>(
      () => UploadVieoUseCases(taskRepository: sl.call()));
  sl.registerLazySingleton<UploadImageUsecases>(
      () => UploadImageUsecases(taskRepository: sl.call()));
  // ////////////////////////////////////////
  sl.registerLazySingleton<GetAllProgramminTaskUseCases>(
      () => GetAllProgramminTaskUseCases(taskRepository: sl.call()));
  sl.registerLazySingleton<GetAllMarktingTaskUseCases>(
      () => GetAllMarktingTaskUseCases(taskRepository: sl.call()));
  sl.registerLazySingleton<GetAllSupportTaskUseCases>(
      () => GetAllSupportTaskUseCases(taskRepository: sl.call()));
  sl.registerLazySingleton<GetAllDesignTaskUseCases>(
      () => GetAllDesignTaskUseCases(taskRepository: sl.call()));

  // /////////////////////////////////////////

  // repositories
  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(firebaseRemoteDataSource: sl.call()));
  sl.registerLazySingleton<ChatRepository>(
      () => ChatRepositoryImpl(settingRemoteDataSource: sl.call()));
  sl.registerLazySingleton<SettingRepository>(
      () => SettingRepositoryImpl(settingRemoteDataSource: sl.call()));
  // ////////////////////////////////////
  sl.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(
        taskRemoteDataSource: sl.call(),
        taskLocalDataSource: sl.call(),
      ));
  // ////////////////////////////////////

  // remoteDataSource
  sl.registerLazySingleton<FirebaseRemoteDataSource>(
    () => FirebaseRemoteDataSourceImpl(
      sl.call(),
      sl.call(),
      sl.call(),
      sl.call(),
      sl.call(),
    ),
  );
  // //////////////////////////////////
  sl.registerLazySingleton<TaskRemoteDataSource>(
    () => TaskRemoteDataSourceImpl(
      storage: sl.call(),
      firestore: sl.call(),
    ),
  );

  // ////////////////////////
  sl.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(firebaseFirestore: sl.call()),
  );
  // //////////////////////
  sl.registerLazySingleton<SettingRemoteDataSource>(
    () => SettingRemoteDataSourceImpl(firebaseFirestore: sl.call()),
  );
  // locadatasources
  sl.registerLazySingleton<TaskLocalDataSource>(
    () => TaskLocalDataSourceImpl(),
  );

  // //////////////////////!

  // external sources

  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  final firebaseChatCore = FirebaseChatCore.instance;
  final notificationService = NotificationService();
  sl.registerSingleton<FirebaseAuth>(auth);
  sl.registerSingleton<FirebaseFirestore>(firestore);
  sl.registerSingleton<FirebaseStorage>(storage);
  sl.registerSingleton<FirebaseChatCore>(firebaseChatCore);
  sl.registerSingleton<NotificationService>(notificationService);
}

 



/*
all this for injection container=> {
bloc
repository
remoteDataSource
localDataSource
External => lieks packages
}
*/ 