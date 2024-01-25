import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:photo_view/photo_view.dart';

import '../../../../Core/Utils/app_colors.dart';
import '../widgets/build_chat_message.dart';

class RoomsUsersPage extends StatelessWidget {
  const RoomsUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<types.Room>>(
      stream: FirebaseChatCore.instance.rooms(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(
              bottom: 200,
            ),
            child: const Text('No rooms'),
          );
        }
        if (snapshot.hasData) {
          final data = snapshot.data;
          return ListView.separated(
            padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
            cacheExtent: 10000,
            separatorBuilder: (context, index) => const Divider(height: 0),
            itemCount: data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () async {
                  final nav = Navigator.of(context);
                  nav.push(MaterialPageRoute(
                    builder: (context) => ChatUserMessagesPage(
                      room: data[index],
                      name: data[index].name!,
                      uid: data[index].id,
                    ),
                  ));
                },
                leading: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PhotoView(
                          imageProvider: CachedNetworkImageProvider(
                              data[index].imageUrl!)),
                    ));
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColors.black,
                    child: CachedNetworkImage(
                      imageUrl: data[index].imageUrl!,
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                title: Text(data[index].name!),
                trailing: CircleAvatar(
                  backgroundColor: AppColors.grey.withOpacity(0.3),
                  child: Text('${index + 1}'),
                ),
              );
            },
          );
        } else {
          return ListView.builder(
            itemCount: 6,
            itemBuilder: (context, index) {
              return const ListTileShimmer();
            },
          );
        }
      },
    );
  }
}
