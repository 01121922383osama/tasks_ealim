import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/build_card_task_widget.dart';
import '../../../Tasks/presentation/manager/cubit/tasks_cubit.dart';

class ProgrammingTaskPage extends StatelessWidget {
  const ProgrammingTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BuildTasksCardWidget(
              taskname:
                  BlocProvider.of<TasksCubit>(context).getAllProgrammingTask()),
        ],
      ),
    );
  }
}
