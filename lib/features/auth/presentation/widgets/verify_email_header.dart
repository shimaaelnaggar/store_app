import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';

class VerifyEmailHeader extends StatelessWidget {
  final String email;
  const VerifyEmailHeader({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 60.h),
        Center(
          child: Container(
            width: 72.r,
            height: 72.r,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.mark_email_unread_rounded,
              size: 36.r,
              color: AppColors.primaryColor,
            ),
          ),
        ),
        SizedBox(height: 28.h),
        Center(
          child: Text(
            'Verify Your Email',
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimaryColor,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Center(
          child: Text(
            'We\'ve sent a 6-digit verification code to your email address.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              height: 1.5,
              color: AppColors.textSecondaryColor,
            ),
          ),
        ),
        SizedBox(height: 12.h),
        Center(
          child: Text(
            email,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimaryColor,
            ),
          ),
        ),
        SizedBox(height: 36.h),
      ],
    );
  }
}
