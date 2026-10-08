import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';

class AuthHeader extends StatelessWidget {
  final String text;
  final String subText;
  final TextAlign? textAlign;

  const AuthHeader(
      {Key? key,
      required this.text,
      required this.subText,
      this.textAlign = TextAlign.start})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30.h),
        Text(
          text,
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimaryColor,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          subText,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.textSecondaryColor,
            height: 1.5,
          ),
        ),
        SizedBox(height: 30.h),
      ],
    );
  }
}
