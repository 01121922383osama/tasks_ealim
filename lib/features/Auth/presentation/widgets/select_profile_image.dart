import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/Utils/assets.dart';
import '../Manager/Picker/pick_image_cubit.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({Key? key, required this.stateImage}) : super(key: key);

  final PickImageState stateImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<PickImageRegisterCubit>(context).pickImage();
      },
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            backgroundImage: stateImage.image.isAbsolute
                ? FileImage(File(stateImage.image.path))
                : const AssetImage(Assets.assetsImagesProfile) as ImageProvider,
            radius: 55,
          ),
          const Icon(Icons.camera),
        ],
      ),
    );
  }
}
