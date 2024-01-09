import 'package:hive/hive.dart';
import '../Utils/app_string.dart';
import '../../features/Tasks/domain/entities/task_user_entie.dart';

void saveData(List<TaskUserEntiy> users) {
  var box = Hive.box<TaskUserEntiy>(AppStrings.allTaskHive);
  box.addAll(users);
}
