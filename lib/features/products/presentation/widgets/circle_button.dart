import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';

class CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? iconColor;
  const CircleButton(
      {Key? key, required this.icon, required this.onPressed, this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceColor,
      borderRadius: BorderRadius.circular(14.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(14.r),
        onTap: onPressed,
        child: SizedBox(
          width: 42.w,
          height: 42.w,
          child: Icon(
            icon,
            size: 20.sp,
            color: iconColor ?? AppColors.textPrimaryColor,
          ),
        ),
      ),
    );
  }
}
