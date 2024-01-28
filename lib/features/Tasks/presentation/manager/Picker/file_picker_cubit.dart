import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'file_picker_state.dart';

class FilePickerImageCubit extends Cubit<FilePickerImageState> {
  FilePickerImageCubit() : super(FilePickerImageInitial(image: XFile('')));

  Future<FilePickerImageState?> pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      emit(FilePickerImageInitial(image: image));
    } else {
      return null;
    }
    return FilePickerImageInitial(image: image);
  }

  deleteImage() {
    emit(FilePickerImageInitial(image: XFile('')));
  }
}

class FilePickerVideoCubit extends Cubit<FilePickerVideoState> {
  FilePickerVideoCubit() : super(FilePickerVideoInitial(video: XFile('')));
  Future<FilePickerImageState?> pickVideo() async {
    ImagePicker videoPicker = ImagePicker();
    XFile? video = await videoPicker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      emit(FilePickerVideoInitial(video: video));
    } else {
      return null;
    }
    return FilePickerImageInitial(image: video);
  }

  deleteVideo() {
    emit(FilePickerVideoInitial(video: XFile('')));
  }
}

class FilePickerMultiImagesCubit extends Cubit<FilePickerMultiImagesState> {
  FilePickerMultiImagesCubit()
      : super(const FilePickerMultiImagesInitial(multiImages: []));

  Future<FilePickerMultiImagesState?> pickMultiImages() async {
    ImagePicker imagesPicker = ImagePicker();
    List<XFile>? images = await imagesPicker.pickMultiImage();

    if (images.isNotEmpty) {
      emit(FilePickerMultiImagesInitial(multiImages: images));
    }

    return null;
  }

  deleteImages() {
    emit(const FilePickerMultiImagesInitial(multiImages: []));
  }
}
