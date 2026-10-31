import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final String email;
  final String fullName;
  final String? profilePicture;
  final String userId;

  const Profile(
      {required this.email,
      required this.fullName,
      required this.profilePicture,
      required this.userId});

  @override
  List<Object?> get props => [email, fullName, profilePicture, userId];
}
