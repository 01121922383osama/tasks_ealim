part of 'pick_image_cubit.dart';

sealed class PickImageState extends Equatable {
  final File image;
  const PickImageState({required this.image});

  @override
  List<Object> get props => [image];
}

final class PickImageInitial extends PickImageState {
  const PickImageInitial({required image}) : super(image: image);
}
