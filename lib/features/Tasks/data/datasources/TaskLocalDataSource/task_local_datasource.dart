// import '../../../../../Core/Utils/app_string.dart';
// import '../../../domain/entities/task_user_entie.dart';

// abstract class TaskLocalDataSource {
//   List<TaskUserEntiy> getAllTask();
//   List<TaskUserEntiy> getAllProgramminTask();
//   List<TaskUserEntiy> getAllMarktingTask();
//   List<TaskUserEntiy> getAllSupportTask();
//   List<TaskUserEntiy> getAllDesignTask();
// }

// class TaskLocalDataSourceImpl extends TaskLocalDataSource {
//   @override
//   List<TaskUserEntiy> getAllTask() {
//     Box<TaskUserEntiy> box = Hive.box<TaskUserEntiy>(AppStrings.allTaskHive);
//     return box.values.toList();
//   }

//   @override
//   List<TaskUserEntiy> getAllDesignTask() {
//     Box<TaskUserEntiy> box = Hive.box<TaskUserEntiy>(AppStrings.designHive);
//     return box.values.toList();
//   }

//   @override
//   List<TaskUserEntiy> getAllMarktingTask() {
//     Box<TaskUserEntiy> box = Hive.box<TaskUserEntiy>(AppStrings.marktingHive);
//     return box.values.toList();
//   }

//   @override
//   List<TaskUserEntiy> getAllProgramminTask() {
//     Box<TaskUserEntiy> box = Hive.box<TaskUserEntiy>(AppStrings.programingHive);
//     return box.values.toList();
//   }

//   @override
//   List<TaskUserEntiy> getAllSupportTask() {
//     Box<TaskUserEntiy> box = Hive.box<TaskUserEntiy>(AppStrings.suportHive);
//     return box.values.toList();
//   }
// }
