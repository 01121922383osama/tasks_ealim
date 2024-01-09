import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'pick_image_state.dart';

class PickImageRegisterCubit extends Cubit<PickImageState> {
  PickImageRegisterCubit() : super(PickImageInitial(image: File('')));
  Future<void> pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      emit(PickImageInitial(image: File(image.path)));
    }
  }
}
