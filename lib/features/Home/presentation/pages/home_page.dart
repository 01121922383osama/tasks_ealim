// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:tasks_ealim/Core/Utils/app_colors.dart';
import 'package:tasks_ealim/Core/Utils/assets.dart';
import 'package:tasks_ealim/Core/Widgets/check_internet.dart';
import 'package:tasks_ealim/features/Home/presentation/pages/all_task_page.dart';
import 'package:tasks_ealim/features/Home/presentation/pages/design_task_page.dart';
import 'package:tasks_ealim/features/Home/presentation/pages/markting_page.dart';
import 'package:tasks_ealim/features/Home/presentation/pages/programming_task_page.dart';
import 'package:tasks_ealim/features/Home/presentation/pages/supurt_task_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChechInternetWidget(
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage(Assets.assetsImagesEalim),
                ),
                const Text(
                  'Boost your productivity',
                  style: TextStyle(
                    shadows: [
                      BoxShadow(
                        color: AppColors.white,
                        blurRadius: 10,
                        spreadRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                ),
                Builder(
                  builder: (context) {
                    return IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: const Icon(Icons.menu),
                    );
                  },
                ),
              ],
            ),
            centerTitle: true,
            bottom: const TabBar(
              indicatorColor: AppColors.white,
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: AppColors.white,
              unselectedLabelColor: AppColors.black,
              tabAlignment: TabAlignment.center,
              isScrollable: true,
              tabs: [
                Tab(child: Text('All Task')),
                Tab(child: Text('Programming')),
                Tab(child: Text('Markting')),
                Tab(child: Text('Support')),
                Tab(child: Text('Design')),
              ],
            ),
          ),
          drawerScrimColor: Colors.grey,
          drawer: const Drawer(),
          body: const TabBarView(
            children: [
              AllTaskPage(),
              ProgrammingTaskPage(),
              MarktingTaskPage(),
              SuportTaskPage(),
              DesignTaskPage(),
            ],
          ),
        ),
      ),
    );
  }
}
