abstract class ControlerTaskEvent {
  const ControlerTaskEvent();
}

class TaskNameEvent extends ControlerTaskEvent {
  final String taskName;
  const TaskNameEvent(this.taskName);
}

class NewTaskEvent extends ControlerTaskEvent {
  final String newTask;
  const NewTaskEvent(this.newTask);
}

class ResetTaskFieldsEvent extends ControlerTaskEvent {}
