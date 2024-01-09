import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Core/Utils/app_string.dart';
import '../../../Tasks/presentation/manager/cubit/tasks_cubit.dart';

import '../widgets/build_card_task_widget.dart';

class AllTaskPage extends StatelessWidget {
  const AllTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BuildTasksCardWidget(
            taskname: BlocProvider.of<TasksCubit>(context)
                .getAllTask(taskName: AppStrings.programingKEY),
          ),
        ],
      ),
    );
  }
}
