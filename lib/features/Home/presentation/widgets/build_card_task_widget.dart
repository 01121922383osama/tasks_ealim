import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import '../../../../Core/Utils/app_colors.dart';
import 'build_details_page.dart';
import '../../../Tasks/domain/entities/task_user_entie.dart';

import '../../../../Core/Utils/media_query_value.dart';

class BuildTasksCardWidget extends StatelessWidget {
  final Future<List<TaskUserEntiy>> taskname;
  const BuildTasksCardWidget({super.key, required this.taskname});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: taskname.asStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: context.height,
            child: ListView.builder(
              itemCount: snapshot.data?.length ?? 8,
              itemBuilder: (BuildContext context, int index) {
                return const ListTileShimmer();
              },
            ),
          );
        }
        if (snapshot.hasData) {
          final data = snapshot.data;
          return ListView.separated(
            padding:
                const EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 5),
            separatorBuilder: (context, index) => SizedBox(
              height: context.height * 0.01,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data!.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          DetailsPage(taskUserEntiy: data[index]),
                    ));
                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(data[index].tasks!,
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          )),
                      Text(data[index].nameOfTask!),
                    ],
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              data[index].newTask!,
                              maxLines: 2,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: AppColors.black,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              data[index].dateTime!,
                              style: TextStyle(
                                color: AppColors.black.withRed(155),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          top: 15,
                          bottom: 10,
                        ),
                        child: Icon(
                          Icons.notifications,
                          color: AppColors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(
            child: Text('Error'),
          );
        }
      },
    );
  }
}
