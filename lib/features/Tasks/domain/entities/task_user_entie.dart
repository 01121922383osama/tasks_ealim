import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'task_user_entie.g.dart';

@HiveType(typeId: 0)
class TaskUserEntiy extends Equatable {
  @HiveField(0)
  final String? tasks;
  @HiveField(1)
  final String? nameOfTask;
  @HiveField(2)
  final String? newTask;
  @HiveField(3)
  final String? imageUrls;
  @HiveField(4)
  final String? videoUrl;
  @HiveField(5)
  final String? dateTime;
  @HiveField(6)
  final bool? isDone;
  @HiveField(7)
  final String? id;
  const TaskUserEntiy({
    this.tasks,
    this.nameOfTask,
    this.newTask,
    this.imageUrls,
    this.videoUrl,
    this.dateTime,
    this.isDone,
    this.id,
  });
  @override
  List<Object?> get props => [
        tasks,
        nameOfTask,
        newTask,
        imageUrls,
        videoUrl,
        dateTime,
        isDone,
        id,
        tasks,
        nameOfTask,
        newTask,
        imageUrls,
        videoUrl,
        dateTime,
        isDone,
        id,
      ];
}
