import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';

class ErrorSection extends StatelessWidget {
  final String message;
  final void Function()? onPressed;
  const ErrorSection({Key? key, required this.message, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline_rounded,
                size: 50.sp,
                color: AppColors.favouriteColor,
              ),
              SizedBox(height: 12.h),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textPrimaryColor,
                  fontSize: 15.sp,
                ),
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: onPressed,
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
