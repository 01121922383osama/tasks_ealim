import 'package:flutter/material.dart';
import '../../../Auth/domain/entities/usr_entities.dart';
import '../widgets/body_edit_page_setting.dart';

class EditPageSetting extends StatelessWidget {
  final UserEntity userEntity;
  const EditPageSetting({super.key, required this.userEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Your Profile'),
      ),
      body: BodyEditPageSetting(userEntity: userEntity),
    );
  }
}
