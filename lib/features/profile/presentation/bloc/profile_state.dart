import '../../domain/entites/profile.dart';

abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileSuccessState extends ProfileState {
  final Profile profile;
  ProfileSuccessState({required this.profile});
}

class ProfileFailureState extends ProfileState {
  final String errorMessage;
  ProfileFailureState({required this.errorMessage});
}
