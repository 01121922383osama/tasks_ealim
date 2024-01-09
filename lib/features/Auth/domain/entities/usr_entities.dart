import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? uuid;
  final String? userName;
  final String? email;
  final String? password;
  final bool? isOnline;
  final String? imageUrl;

  const UserEntity({
    this.uuid,
    this.userName,
    required this.email,
    required this.password,
    this.isOnline = false,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [
        uuid,
        userName,
        email,
        password,
        isOnline,
        imageUrl,
      ];
}
