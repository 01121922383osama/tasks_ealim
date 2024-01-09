// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_user_entie.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskUserEntiyAdapter extends TypeAdapter<TaskUserEntiy> {
  @override
  final int typeId = 0;

  @override
  TaskUserEntiy read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskUserEntiy(
      tasks: fields[0] as String?,
      nameOfTask: fields[1] as String?,
      newTask: fields[2] as String?,
      imageUrls: fields[3] as String?,
      videoUrl: fields[4] as String?,
      dateTime: fields[5] as String?,
      isDone: fields[6] as bool?,
      id: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TaskUserEntiy obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.tasks)
      ..writeByte(1)
      ..write(obj.nameOfTask)
      ..writeByte(2)
      ..write(obj.newTask)
      ..writeByte(3)
      ..write(obj.imageUrls)
      ..writeByte(4)
      ..write(obj.videoUrl)
      ..writeByte(5)
      ..write(obj.dateTime)
      ..writeByte(6)
      ..write(obj.isDone)
      ..writeByte(7)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskUserEntiyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
