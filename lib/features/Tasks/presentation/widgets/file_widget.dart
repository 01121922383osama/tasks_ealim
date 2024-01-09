import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/Picker/file_picker_cubit.dart';

class FilesWidget extends StatelessWidget {
  const FilesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilePickerImageCubit, FilePickerImageState>(
      builder: (context, imageState) {
        return BlocBuilder<FilePickerVideoCubit, FilePickerVideoState>(
          builder: (context, stateVideo) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocBuilder<FilePickerMultiImagesCubit,
                    FilePickerMultiImagesState>(
                  builder: (context, stateMultiImages) {
                    return ListTile(
                      onTap: () {
                        context.read<FilePickerImageCubit>().pickImage();
                        // showDialog(
                        //   context: context,
                        //   builder: (BuildContext context) {
                        //     return CustomDialog(
                        //       title: AppStrings.choseImage,
                        //       oneImage: () {
                        //         context
                        //             .read<FilePickerImageCubit>()
                        //             .pickImage();
                        //         context
                        //             .read<FilePickerMultiImagesCubit>()
                        //             .deleteImages();
                        //         Navigator.pop(context);
                        //       },
                        //       multiImage: () {
                        //         context
                        //             .read<FilePickerMultiImagesCubit>()
                        //             .pickMultiImages();
                        //         Navigator.pop(context);
                        //       },
                        //       text1: 'One',
                        //       text2: 'multiple',
                        //     );
                        //   },
                        // );
                      },
                      leading: stateMultiImages.multiImages.isNotEmpty
                          ? IconButton.filledTonal(
                              onPressed: () {
                                context
                                    .read<FilePickerMultiImagesCubit>()
                                    .deleteImages();
                              },
                              icon: const Icon(Icons.close),
                            )
                          : imageState.image.name.isNotEmpty
                              ? IconButton.filledTonal(
                                  onPressed: () {
                                    context
                                        .read<FilePickerImageCubit>()
                                        .deleteImage();
                                  },
                                  icon: const Icon(Icons.close),
                                )
                              : null,
                      title: stateMultiImages.multiImages.isEmpty
                          ? Text(
                              (imageState.image.name.toString().isEmpty
                                  ? 'Image'
                                  : imageState.image.name.toString()),
                            )
                          : Text(
                              '${stateMultiImages.multiImages.length} Images'),
                      trailing: const Icon(Icons.image),
                    );
                  },
                ),
                ListTile(
                  onTap: () {
                    context.read<FilePickerVideoCubit>().pickVideo();
                  },
                  leading: stateVideo.video.name.isNotEmpty
                      ? IconButton.filledTonal(
                          onPressed: () {
                            context.read<FilePickerVideoCubit>().deleteVideo();
                          },
                          icon: const Icon(Icons.close))
                      : null,
                  title: Text(stateVideo.video.name.toString().isEmpty
                      ? 'Video'
                      : stateVideo.video.name.toString()),
                  trailing: const Icon(Icons.video_camera_back_outlined),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
