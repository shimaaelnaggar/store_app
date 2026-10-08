import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/features/auth/presentation/bloc/verify_email/verify_email_event.dart';
import 'package:store/features/auth/presentation/bloc/verify_email/verify_email_state.dart';

import '../../../domain/usecases/resend_otp_usecase.dart';
import '../../../domain/usecases/verify_email_usecase.dart';

class VerifyEmailBloc extends Bloc<VerifyEmailEvent, VerifyEmailState> {
  final VerifyEmailUseCase verifyEmailUseCase;
  final ResendOtpUseCase resendOtpUseCase;

  VerifyEmailBloc({
    required this.verifyEmailUseCase,
    required this.resendOtpUseCase,
  }) : super(VerifyEmailInitialState()) {
    on<VerifyEmailRequestedEvent>((event, emit) async {
      emit(VerifyEmailLoadingState());

      final result = await verifyEmailUseCase.execute(event.verifyEmail);

      result.fold(
        (failure) {
          emit(
            VerifyEmailErrorState(
              errorMessage: failure.errorMessage,
            ),
          );
        },
        (_) {
          emit(VerifyEmailSuccessState());
        },
      );
    });

    on<ResendOtpRequestedEvent>((event, emit) async {
      emit(ResendOtpLoadingState());

      final result = await resendOtpUseCase.execute(event.email);

      result.fold(
        (failure) {
          emit(
            ResendOtpErrorState(
              errorMessage: failure.errorMessage,
            ),
          );
        },
        (_) {
          emit(ResendOtpSuccessState());
        },
      );
    });
  }
}
