import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/features/auth/presentation/bloc/register/register_event.dart';
import 'package:store/features/auth/presentation/bloc/register/register_state.dart';

import '../../../domain/usecases/create_account_usecase.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final CreateAccountUseCase createAccountUseCase;

  RegisterBloc({required this.createAccountUseCase})
      : super(RegisterInitialState()) {
    on<CreateAccountEvent>((event, emit) async {
      emit(RegisterLoadingState());
      final result = await createAccountUseCase.execute(event.register);
      result.fold(
        (failure) => emit(RegisterErrorState(failure.errorMessage)),
        (_) => emit(RegisterSuccessState(
          email: event.register.email
        )),
      );
    });
  }
}
