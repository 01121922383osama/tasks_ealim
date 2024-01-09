import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:photo_view/photo_view.dart';
import 'package:tasks_ealim/Core/Widgets/custom_texts.dart';
import 'package:tasks_ealim/features/Chat/presentation/widgets/build_chat_message.dart';

import '../../../../Core/Utils/app_colors.dart';

class BodyAllUsersPage extends StatelessWidget {
  const BodyAllUsersPage({super.key});
  void _handlePressed(types.User otherUser, BuildContext context,
      {required String otherUserId, required String userName}) async {
    final nav = ScaffoldMessenger.of(context);
    try {
      final navigator = Navigator.of(context);
      final room = await FirebaseChatCore.instance.createRoom(otherUser);
      await navigator.push(
        MaterialPageRoute(
          builder: (context) => ChatUserMessagesPage(
            room: room,
            name: userName,
            uid: otherUserId,
          ),
        ),
      );
    } catch (e) {
      nav.showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
        ),
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<types.User>>(
      stream: FirebaseChatCore.instance.users(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListView.builder(
            itemCount: snapshot.data?.length ?? 6,
            itemBuilder: (BuildContext context, int index) {
              return const ListTileShimmer();
            },
          );
        }
        if (snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No User Found Yet...!'),
          );
        }
        if (snapshot.hasData) {
          final data = snapshot.data;
          return ListView.separated(
            padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
            cacheExtent: 10000,
            separatorBuilder: (context, index) => const Divider(height: 0),
            itemCount: data!.length,
            itemBuilder: (BuildContext context, int index) {
              final user = snapshot.data![index];
              return ListTile(
                onTap: () => _handlePressed(
                  user,
                  context,
                  otherUserId: data[index].id,
                  userName: data[index].firstName!,
                ),
                leading: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PhotoView(
                          imageProvider:
                              CachedNetworkImageProvider(user.imageUrl!)),
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
                title: CustomTexts(text: data[index].firstName!),
                trailing: CircleAvatar(
                  backgroundColor: AppColors.grey.withOpacity(0.3),
                  child: Text('${index + 1}'),
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
