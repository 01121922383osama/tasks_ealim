import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../Core/Utils/app_colors.dart';
import '../../../../Core/Utils/app_shadow.dart';
import '../../../../Core/Utils/app_string.dart';
import '../../../../Core/Widgets/check_internet.dart';
import '../../../../Core/Widgets/custom_texts.dart';
import 'add_task_page.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChechInternetWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Tasks',
            style: TextStyle(shadows: shadow),
          ),
        ),
        body: GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: _view.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddTasksPage(title: _view[index]),
                ));
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppColors.lightRed),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl: _images[index],
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                    CustomTexts(text: _view[index])
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

List<String> _images = [
  'https://imgs.search.brave.com/nfrrF8YIrDXeV2Mv9ZH8rrUFg4x4DY86KOSO55GoHPg/rs:fit:860:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzAxLzg4LzkxLzA1/LzM2MF9GXzE4ODkx/MDUxMF9YWFFQMnZn/V1JPRVpvMFk4N21v/UFUzQzdCZjFYd1JS/Sy5qcGc',
  'https://imgs.search.brave.com/wCoWLu0fmfMVHypaw2nHPpbXsstdm1PQe8tX-v53Ay4/rs:fit:860:0:0/g:ce/aHR0cHM6Ly90My5m/dGNkbi5uZXQvanBn/LzAyLzEwLzA3LzA2/LzM2MF9GXzIxMDA3/MDY1OV9BNW10aGtF/VE8zbDJaUktrUnBo/b1JjQkRtb2xOTXRl/Ti5qcGc',
  'https://imgs.search.brave.com/xp2oQP-BCsMmFcNaIqW7KkpTyzTEaGw3BkZ9cQH3040/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9zdGF0/aWMzLmRlcG9zaXRw/aG90b3MuY29tLzEw/MDU5NzkvMjA3L2kv/NjAwL2RlcG9zaXRw/aG90b3NfMjA3NTg0/Ni1zdG9jay1waG90/by1zdWNjZXNzZnVs/LWN1c3RvbWVyLXN1/cHBvcnQtY2FsbC5q/cGc',
  'https://imgs.search.brave.com/rnW2NnsY-eeEXotLTuhW2Q-cUIATYrF4wCf2BEIeny0/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/cHJlbWl1bS1waG90/by9jcmVhdGUtY3Jl/YXRpdml0eS1pZGVh/cy1kZXNpZ24tY29u/Y2VwdF81Mzg3Ni0x/MjIyMzguanBnP3Np/emU9NjI2JmV4dD1q/cGc',
];

List<String> _view = [
  AppStrings.programingKEY,
  AppStrings.marktingKEY,
  AppStrings.supportKEY,
  AppStrings.designKEY,
];
