import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import '../../../../Core/Utils/app_colors.dart';
import '../../../../Core/Utils/media_query_value.dart';
import 'package:video_player/video_player.dart';

class BuildVideoWidget extends StatelessWidget {
  final String url;
  const BuildVideoWidget({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    final VideoPlayerController videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(url));
    return SizedBox(
      height: context.height * 0.4,
      child: Chewie(
        controller: ChewieController(
          videoPlayerController: videoPlayerController,
          autoInitialize: true,
          placeholder: const VideoShimmer(),
          cupertinoProgressColors: ChewieProgressColors(
            playedColor: AppColors.red,
            backgroundColor: AppColors.red,
            bufferedColor: AppColors.red,
          ),
          errorBuilder: (context, errorMessage) => const Center(
            child: Text(
              'Check Your Internet',
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          zoomAndPan: true,
        ),
      ),
    );
  }
}
