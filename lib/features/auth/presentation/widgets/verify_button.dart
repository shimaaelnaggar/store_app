import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/helper/show_snack_bar.dart';
import 'custom_button.dart';
import '../../domain/entities/verify_email.dart';
import '../bloc/verify_email/verify_email_bloc.dart';
import '../bloc/verify_email/verify_email_event.dart';
import '../bloc/verify_email/verify_email_state.dart';

class VerifyButton extends StatelessWidget {
  final String email;
  final String otp;
  const VerifyButton({Key? key, required this.email, required this.otp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 24.h),
        SizedBox(
          width: double.infinity,
          height: 52.h,
          child: BlocBuilder<VerifyEmailBloc, VerifyEmailState>(
            builder: (context, state) {
              if (state is VerifyEmailLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                );
              }

              return CustomElevatedButton(
                text: 'Verify Email',
                onPressed: () {
                  if (otp.isEmpty) {
                    showSnackBar(
                      context: context,
                      message: 'Please enter the verification code',
                      backgroundColor: Colors.red,
                    );
                    return;
                  }

                  context.read<VerifyEmailBloc>().add(
                        VerifyEmailRequestedEvent(
                          verifyEmail: VerifyEmail(
                            email: email,
                            otp: otp,
                          ),
                        ),
                      );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
