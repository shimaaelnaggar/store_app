import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:store/features/auth/presentation/widgets/sign_up_form.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/helper/show_message.dart';

import '../bloc/register/register_bloc.dart';
import '../bloc/register/register_state.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RegisterBloc>(),
      child: BlocListener<RegisterBloc, RegisterState>(
        listener: (BuildContext context, RegisterState state) {
          if (state is RegisterSuccessState) {
            context.go(
              '/verify-email',
              extra: state.email,
            );
          } else if (state is RegisterErrorState) {
            showMessage(
              context: context,
              message: state.errorMessage,
              backgroundColor: Colors.red,
            );
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24.r),
              child: const SignUpForm(),
            ),
          ),
        ),
      ),
    );
  }
}
