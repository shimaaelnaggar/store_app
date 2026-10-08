import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import 'custom_text_button.dart';

class VerifyEmailActions extends StatelessWidget {
  const VerifyEmailActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        CustomTextButton(
            text: "Didn't receive OTP?",
            onPressed: () {},
            buttonText: 'Resend'),
        SizedBox(height: 30.h),
        Center(
          child: TextButton(
            onPressed: () => context.go('/login'),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 13.sp,
                  color: AppColors.textSecondaryColor,
                ),
                children: const [
                  TextSpan(
                    text: 'Already verified? ',
                  ),
                  TextSpan(
                    text: 'Go to Login',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
