import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/features/profile/presentation/bloc/profile_event.dart';
import 'package:store/features/profile/presentation/bloc/profile_state.dart';

import '../../domain/usecases/get_profile_usecase.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;

  ProfileBloc({required this.getProfileUseCase})
      : super(ProfileInitialState()) {
    on<GetProfileEvent>((event, emit) async {
      emit(ProfileLoadingState());
      final result = await getProfileUseCase.execute();
      result.fold((failure) {
        emit(ProfileFailureState(errorMessage: failure.errorMessage));
      }, (profile) {
        emit(ProfileSuccessState(profile: profile));
      });
    });
  }
}
