import 'package:equatable/equatable.dart';

class TaskUserEntiy extends Equatable {
  final String? tasks;
  final String? nameOfTask;
  final String? newTask;
  final String? imageUrls;
  final String? videoUrl;
  final String? dateTime;
  final bool? isDone;
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
