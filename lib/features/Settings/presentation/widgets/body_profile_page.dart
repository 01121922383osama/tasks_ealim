import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:photo_view/photo_view.dart';
import '../../../../Core/Utils/media_query_value.dart';
import '../../../../Core/Widgets/custom_button.dart';

import '../../../../Core/Widgets/custom_texts.dart';
import '../cubit/setting_cubit.dart';
import '../pages/edit_page_setting.dart';

class BodyProfilePage extends StatelessWidget {
  const BodyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: BlocProvider.of<SettingCubit>(context).getCurrentUserData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Error'),
          );
        }
        if (snapshot.hasData) {
          final user = snapshot.data;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PhotoView(
                          imageProvider:
                              CachedNetworkImageProvider(user.imageUrl!)),
                    ));
                  },
                  child: CircleAvatar(
                    radius: 65,
                    child: CachedNetworkImage(
                      imageUrl: user!.imageUrl!,
                      fit: BoxFit.cover,
                      imageBuilder: (context, imageProvider) {
                        return CircleAvatar(
                          radius: 65,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                              ),
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: const Icon(CupertinoIcons.profile_circled),
                  title: CustomTexts(text: user.userName!),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: const Icon(CupertinoIcons.mail_solid),
                  title: CustomTexts(text: user.email!),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: 'Edit',
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditPageSetting(userEntity: user),
                    ));
                  },
                  width: context.width,
                  height: context.height * 0.07,
                ),
              ],
            ),
          );
        } else {
          return const Column(
            children: [
              ProfilePageShimmer(
                beginAlign: Alignment.topCenter,
                endAlign: Alignment.bottomCenter,
                hasCustomColors: true,
                isPurplishMode: true,
              ),
              ListTileShimmer(),
              ListTileShimmer(),
            ],
          );
        }
      },
    );
  }
}
