import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../Core/Utils/media_query_value.dart';
import '../../../../Core/Widgets/custom_button.dart';
import '../../../Auth/domain/entities/usr_entities.dart';
import '../cubit/setting_cubit.dart';

class BodyEditPageSetting extends StatefulWidget {
  final UserEntity userEntity;
  const BodyEditPageSetting({super.key, required this.userEntity});

  @override
  State<BodyEditPageSetting> createState() => _BodyEditPageSettingState();
}

class _BodyEditPageSettingState extends State<BodyEditPageSetting> {
  late TextEditingController username;
  late TextEditingController userEmail;
  late TextEditingController userPassword;
  ImagePicker imagePicker = ImagePicker();
  String? pathImage;

  @override
  void initState() {
    username = TextEditingController(text: widget.userEntity.userName);
    userEmail = TextEditingController(text: widget.userEntity.email);
    userPassword = TextEditingController(text: widget.userEntity.password);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: BlocBuilder<SettingCubit, SettingState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      imagePicker
                          .pickImage(source: ImageSource.gallery)
                          .then((value) => {
                                if (value != null)
                                  {
                                    setState(() {
                                      pathImage = value.path;
                                    })
                                  }
                              });
                    },
                    child: pathImage != null
                        ? CircleAvatar(
                            radius: 65,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: FileImage(File(pathImage!)),
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                ),
                                borderRadius: BorderRadius.circular(999),
                              ),
                            ),
                          )
                        : CachedNetworkImage(
                            imageUrl: widget.userEntity.imageUrl!,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            imageBuilder: (context, imageProvider) {
                              return CircleAvatar(
                                radius: 65,
                                child: CachedNetworkImage(
                                  imageUrl: widget.userEntity.imageUrl!,
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
                                          borderRadius:
                                              BorderRadius.circular(999),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                            errorWidget: (context, url, error) => const Center(
                              child: Icon(Icons.error),
                            ),
                          ),
                  ),
                  const SizedBox(height: 20),
                  CustomEditProfile(
                    lableText: 'User Name',
                    userName: username,
                  ),
                  const SizedBox(height: 20),
                  CustomEditProfile(
                    lableText: 'User Email',
                    userName: userEmail,
                  ),
                  const SizedBox(height: 20),
                  CustomEditProfile(
                    lableText: 'User Password',
                    userName: userPassword,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: state is SettingLoading ? 'Upadate...' : 'Upadate',
                    onPressed: () {
                      BlocProvider.of<SettingCubit>(context)
                          .updateUserData(
                        userEntity: UserEntity(
                          email: userEmail.text.trim(),
                          password: userPassword.text.trim(),
                          imageUrl: pathImage ?? widget.userEntity.imageUrl,
                          userName: username.text.trim(),
                          uuid: widget.userEntity.uuid,
                          isOnline: widget.userEntity.isOnline,
                        ),
                      )
                          .whenComplete(() {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green,
                            animation: const AlwaysStoppedAnimation(1),
                            dismissDirection: DismissDirection.startToEnd,
                            behavior: SnackBarBehavior.floating,
                            showCloseIcon: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            content: const Text('Update Success'),
                          ),
                        );

                        Navigator.pop(context);
                      });
                    },
                    width: context.width,
                    height: context.height * 0.07,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CustomEditProfile extends StatelessWidget {
  final TextEditingController userName;
  final String lableText;
  const CustomEditProfile(
      {super.key, required this.userName, required this.lableText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      controller: userName,
      decoration: InputDecoration(
        label: Text(lableText),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        isDense: true,
      ),
    );
  }
}
