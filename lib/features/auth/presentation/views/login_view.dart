import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:store/features/auth/presentation/widgets/login_form.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/helper/show_snack_bar.dart';
import '../bloc/login/login_bloc.dart';
import '../bloc/login/login_state.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginBloc>(),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (BuildContext context, LoginState state) {
          if (state is LoginSuccessState) {
            context.go(
              '/',
            );
          } else if (state is LoginErrorState) {
            showSnackBar(
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
              child: const LoginForm(),
            ),
          ),
        ),
      ),
    );
  }
}
