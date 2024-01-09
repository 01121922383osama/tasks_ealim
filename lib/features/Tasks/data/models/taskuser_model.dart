import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/task_user_entie.dart';

class TaskUserModel extends TaskUserEntiy {
  const TaskUserModel({
    final String? tasks,
    final String? nameOfTask,
    final String? newTask,
    final String? imageUrls,
    final String? videoUrl,
    final String? dateTime,
    final bool? isDone,
    final String? id,
  }) : super(
          tasks: tasks,
          nameOfTask: nameOfTask,
          newTask: newTask,
          imageUrls: imageUrls,
          videoUrl: videoUrl,
          dateTime: dateTime,
          isDone: isDone,
          id: id,
        );

  factory TaskUserModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    return TaskUserModel(
      tasks: snapshot.get('tasks'),
      nameOfTask: snapshot.get('nameOfTask'),
      newTask: snapshot.get('newTask'),
      imageUrls: snapshot.get('imageUrls'),
      videoUrl: snapshot.get('videoUrl'),
      dateTime: snapshot.get('dateTime'),
      isDone: snapshot.get('isDone'),
      id: snapshot.get('id'),
    );
  }
  Map<String, dynamic> toDocumentSnapshot() {
    return {
      'tasks': tasks,
      'nameOfTask': nameOfTask,
      'newTask': newTask,
      'imageUrls': imageUrls,
      'videoUrl': videoUrl,
      'dateTime': dateTime,
      'isDone': isDone,
      'id': id,
    };
  }
}
