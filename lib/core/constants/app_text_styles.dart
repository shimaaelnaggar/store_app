import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/core/constants/app_colors.dart';

class AppTextStyles {
  static TextStyle bodyLarge = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimaryColor
    
  );

  static  TextStyle bodySemiBold = TextStyle(
    fontSize: 11.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimaryColor
  );

  static  TextStyle bodyRegular = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimaryColor
  );

  static  TextStyle bodyMedium = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondaryColor
  );

 
}