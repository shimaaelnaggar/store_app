import '../../domain/entites/profile.dart';

class ProfileModel extends Profile {
  const ProfileModel({
    required String email,
    required String fullName,
    required String? profilePicture,
    required String userId,
  }) : super(
          email: email,
          fullName: fullName,
          profilePicture: profilePicture,
          userId: userId,
        );

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      email: json['email'],
      fullName: json['fullName'],
      profilePicture: json['profilePicture'],
      userId: json['userId'],
    );
  }
}
