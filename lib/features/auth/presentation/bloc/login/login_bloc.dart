import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/storage/auth_storage.dart';
import '../../../domain/usecases/login_use_case.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  final AuthStorage authStorage;
  LoginBloc({required this.loginUseCase, required this.authStorage})
      : super(LoginInitialState()) {
    on<LoginRequestedEvent>((event, emit) async {
      emit(LoginLoadingState());
      final result = await loginUseCase.execute(event.login);
      await result.fold((failure) async {
        emit(LoginErrorState(
          errorMessage: failure.errorMessage,
        ));
      }, (loginResponse) async {
        try {
          await authStorage.saveTokens(
            accessToken: loginResponse.accessToken,
            refreshToken: loginResponse.refreshToken,
          );

          emit(LoginSuccessState(
            loginResponse: loginResponse,
          ));
        } catch (e) {
          emit(LoginErrorState(
            errorMessage: 'Failed to save tokens',
          ));
        }
      });
    });
  }
}
