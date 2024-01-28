import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../Core/Utils/app_string.dart';
import '../../../domain/entities/task_user_entie.dart';
import '../../models/taskuser_model.dart';

abstract class TaskRemoteDataSource {
  Future<void> createTask({required TaskUserEntiy taskUserEntiy});
  Future<void> deleteTask({required TaskUserEntiy taskUserEntiy});
  Future<void> updateTask({required TaskUserEntiy taskUserEntiy});
  Future<List<TaskUserEntiy>> getAllTask({required String taskNmae});
  Future<List<TaskUserEntiy>> getAllProgramminTask();
  Future<List<TaskUserEntiy>> getAllMarktingTask();
  Future<List<TaskUserEntiy>> getAllSupportTask();
  Future<List<TaskUserEntiy>> getAllDesignTask();
  Future<TaskUserEntiy?> getTaskByTaskName({required String taskName});
  Future<String> uploadImages({required File images});
  Future<String> uploadVideo({required XFile video});
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final FirebaseStorage storage;
  final FirebaseFirestore firestore;

  TaskRemoteDataSourceImpl({required this.storage, required this.firestore});
  @override
  Future<void> createTask({required TaskUserEntiy taskUserEntiy}) async {
    final image = await uploadImages(images: File(taskUserEntiy.imageUrls!));
    final video = await uploadVideo(video: XFile(taskUserEntiy.videoUrl!));
    final collection = firestore.collection(taskUserEntiy.tasks!);
    final newUser = TaskUserModel(
      id: taskUserEntiy.id,
      tasks: taskUserEntiy.tasks,
      nameOfTask: taskUserEntiy.nameOfTask,
      newTask: taskUserEntiy.newTask,
      dateTime: taskUserEntiy.dateTime,
      imageUrls: image,
      videoUrl: video,
      isDone: taskUserEntiy.isDone,
    ).toDocumentSnapshot();

    await collection.doc(taskUserEntiy.id).set(newUser);
  }

  @override
  Future<void> deleteTask({required TaskUserEntiy taskUserEntiy}) async {
    final collection = firestore.collection(taskUserEntiy.tasks!);
    final userDoc = await collection.doc(taskUserEntiy.id).get();
    if (userDoc.exists) {
      await collection.doc(taskUserEntiy.id).delete();
    } else {
      throw Exception('No such document');
    }
  }

  @override
  Future<List<TaskUserEntiy>> getAllTask({required String taskNmae}) async {
    final markting = await getAllMarktingTask();
    final support = await getAllSupportTask();
    final design = await getAllDesignTask();

    List<TaskUserEntiy> fetchedUsers = [];

    QuerySnapshot querySnapshot = await firestore.collection(taskNmae).get();
    for (var element in querySnapshot.docs) {
      fetchedUsers.add(TaskUserModel.fromDocumentSnapshot(element));
    }

    return fetchedUsers + markting + support + design;
  }

  @override
  Future<TaskUserEntiy?> getTaskByTaskName({required String taskName}) async {
    QuerySnapshot querySnapshot = await firestore.collection(taskName).get();
    for (var element in querySnapshot.docs) {
      var taskData = TaskUserModel.fromDocumentSnapshot(element);
      if (taskData.tasks == taskName) {
        return taskData;
      }
    }
    return null;
  }

  @override
  Future<void> updateTask({required TaskUserEntiy taskUserEntiy}) async {
    final video = await uploadVideo(video: XFile(taskUserEntiy.videoUrl!));
    final collection = firestore.collection(taskUserEntiy.tasks!);
    final newUser = TaskUserModel(
      id: taskUserEntiy.id,
      tasks: taskUserEntiy.tasks,
      nameOfTask: taskUserEntiy.nameOfTask,
      newTask: taskUserEntiy.newTask,
      dateTime: taskUserEntiy.dateTime,
      imageUrls: taskUserEntiy.imageUrls,
      videoUrl: video,
      isDone: taskUserEntiy.isDone,
    ).toDocumentSnapshot();

    final userDoc = await collection.doc(taskUserEntiy.id).get();
    if (userDoc.exists) {
      await collection.doc(taskUserEntiy.id).update(newUser);
    } else {
      await collection.doc(taskUserEntiy.id).set(newUser);
    }
  }

  @override
  Future<String> uploadImages({required File? images}) async {
    try {
      if (images == null || !images.existsSync()) {
        return '';
      }

      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference =
          FirebaseStorage.instance.ref().child('images/$fileName.jpg');
      UploadTask uploadTask = storageReference.putFile(images);
      TaskSnapshot taskSnapshot = await uploadTask;

      if (taskSnapshot.state == TaskState.success) {
        String downloadURL = await storageReference.getDownloadURL();
        return downloadURL;
      } else {
        return '';
      }
    } catch (e) {
      return '';
    }
  }

  @override
  Future<String> uploadVideo({required XFile? video}) async {
    try {
      if (video == null) {
        return '';
      }

      File file = File(video.path);

      if (!file.existsSync()) {
        return '';
      }

      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference =
          FirebaseStorage.instance.ref().child('videos/$fileName.mp4');
      UploadTask uploadTask = storageReference.putFile(file);

      await uploadTask.whenComplete(() {});

      if (uploadTask.snapshot.state == TaskState.success) {
        String downloadURL = await storageReference.getDownloadURL();
        return downloadURL;
      } else {
        return '';
      }
    } catch (e) {
      return '';
    }
  }

  @override
  Future<List<TaskUserEntiy>> getAllDesignTask() async {
    List<TaskUserEntiy> fetchedUsers = [];
    QuerySnapshot querySnapshot =
        await firestore.collection(AppStrings.designKEY).get();
    for (var element in querySnapshot.docs) {
      fetchedUsers.add(TaskUserModel.fromDocumentSnapshot(element));
    }

    return fetchedUsers;
  }

  @override
  Future<List<TaskUserEntiy>> getAllMarktingTask() async {
    List<TaskUserEntiy> fetchedUsers = [];
    QuerySnapshot querySnapshot =
        await firestore.collection(AppStrings.marktingKEY).get();
    for (var element in querySnapshot.docs) {
      fetchedUsers.add(TaskUserModel.fromDocumentSnapshot(element));
    }

    return fetchedUsers;
  }

  @override
  Future<List<TaskUserEntiy>> getAllProgramminTask() async {
    List<TaskUserEntiy> fetchedUsers = [];
    QuerySnapshot querySnapshot =
        await firestore.collection(AppStrings.programingKEY).get();
    for (var element in querySnapshot.docs) {
      fetchedUsers.add(TaskUserModel.fromDocumentSnapshot(element));
    }
    return fetchedUsers;
  }

  @override
  Future<List<TaskUserEntiy>> getAllSupportTask() async {
    List<TaskUserEntiy> fetchedUsers = [];
    QuerySnapshot querySnapshot =
        await firestore.collection(AppStrings.supportKEY).get();
    for (var element in querySnapshot.docs) {
      fetchedUsers.add(TaskUserModel.fromDocumentSnapshot(element));
    }

    return fetchedUsers;
  }
}
