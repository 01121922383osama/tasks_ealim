part of 'file_picker_cubit.dart';

sealed class FilePickerImageState extends Equatable {
  final XFile image;
  const FilePickerImageState({required this.image});

  @override
  List<Object> get props => [image];
}

final class FilePickerImageInitial extends FilePickerImageState {
  const FilePickerImageInitial({required super.image});
}

sealed class FilePickerVideoState extends Equatable {
  final XFile video;
  const FilePickerVideoState({required this.video});

  @override
  List<Object> get props => [video];
}

final class FilePickerVideoInitial extends FilePickerVideoState {
  const FilePickerVideoInitial({required super.video});
}

sealed class FilePickerMultiImagesState extends Equatable {
  final List<XFile> multiImages;
  const FilePickerMultiImagesState({required this.multiImages});

  @override
  List<Object> get props => [multiImages];
}

final class FilePickerMultiImagesInitial extends FilePickerMultiImagesState {
  const FilePickerMultiImagesInitial({required super.multiImages});
}

sealed class FilePickerMultiVideoState extends Equatable {
  final List<XFile> multiVideos;
  const FilePickerMultiVideoState({required this.multiVideos});

  @override
  List<Object> get props => [multiVideos];
}

final class FilePickerMultiVideoInitial extends FilePickerMultiVideoState {
  const FilePickerMultiVideoInitial({required super.multiVideos});
}
