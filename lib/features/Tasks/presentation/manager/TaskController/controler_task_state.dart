class ControlerTaskState {
  final String taskName;
  final String newTask;
  const ControlerTaskState({
    this.taskName = '',
    this.newTask = '',
  });

  ControlerTaskState copyWith({
    String? email,
    String? password,
  }) {
    return ControlerTaskState(
      taskName: email ?? taskName,
      newTask: password ?? newTask,
    );
  }
}
