import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:store/features/auth/presentation/widgets/verify_button.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/helper/show_snack_bar.dart';
import '../bloc/verify_email/verify_email_bloc.dart';
import '../bloc/verify_email/verify_email_event.dart';
import '../bloc/verify_email/verify_email_state.dart';
import '../widgets/otp_input.dart';
import '../widgets/verify_email_header.dart';

class VerifyEmailView extends StatefulWidget {
  final String email;
  const VerifyEmailView({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  String otp = '';

  Timer? timer;

  int remainingSeconds = 60;

  bool get canResend => remainingSeconds == 0;

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  void startTimer() {
    timer?.cancel();

    setState(() {
      remainingSeconds = 60;
    });

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (remainingSeconds > 0) {
          setState(() {
            remainingSeconds--;
          });
        } else {
          timer.cancel();
        }
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<VerifyEmailBloc>(),
      child: BlocListener<VerifyEmailBloc, VerifyEmailState>(
        listener: (context, state) {
          if (state is VerifyEmailSuccessState) {
            showSnackBar(
              context: context,
              message: 'Email verified successfully',
              backgroundColor: Colors.green,
            );

            context.go('/login');
          } else if (state is VerifyEmailErrorState) {
            showSnackBar(
              context: context,
              message: state.errorMessage,
              backgroundColor: Colors.red,
            );
          } else if (state is ResendOtpSuccessState) {
            showSnackBar(
              context: context,
              message: 'A new verification code has been sent',
              backgroundColor: Colors.green,
            );

            startTimer();
          } else if (state is ResendOtpErrorState) {
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VerifyEmailHeader(
                    email: widget.email,
                  ),
                  OtpInput(
                    onChanged: (value) {
                      setState(() {
                        otp = value;
                      });
                    },
                  ),
                  VerifyButton(
                    email: widget.email,
                    otp: otp,
                  ),
                  SizedBox(height: 24.h),
                  Center(
                    child: Text(
                      canResend
                          ? 'You can request a new code'
                          : 'Resend code in $remainingSeconds seconds',
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Center(
                    child: BlocBuilder<VerifyEmailBloc, VerifyEmailState>(
                      builder: (context, state) {
                        final isResending = state is ResendOtpLoadingState;

                        return TextButton(
                          onPressed: !canResend || isResending
                              ? null
                              : () {
                                  context.read<VerifyEmailBloc>().add(
                                        ResendOtpRequestedEvent(
                                          email: widget.email,
                                        ),
                                      );
                                },
                          child: isResending
                              ? const CircularProgressIndicator()
                              : const Text(
                                  'Resend OTP',
                                ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
