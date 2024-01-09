import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Manager/obscure_text.dart';

class ObsecUreIconWIdget extends StatelessWidget {
  const ObsecUreIconWIdget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ObscureTextRegisterCubit, bool>(
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            context.read<ObscureTextRegisterCubit>().toggle();
          },
          icon: Icon(state ? Icons.visibility : Icons.visibility_off),
        );
      },
    );
  }
}
