import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/Toggle/toggle_cubit.dart';
import '../widgets/build_screen.dart';

class AppMain extends StatelessWidget {
  const AppMain({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToggleCubit, ToggleState>(
      builder: (context, state) {
        return Scaffold(
          body: buildScreens()[state.index],
          bottomNavigationBar: NavigationBar(
            animationDuration: const Duration(seconds: 1),
            destinations: navBarsItems(),
            selectedIndex: state.index,
            onDestinationSelected: (value) {
              context.read<ToggleCubit>().toggle(value);
            },
          ),
        );
      },
    );
  }
}
