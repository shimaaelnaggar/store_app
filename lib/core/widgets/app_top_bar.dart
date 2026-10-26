import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:store/features/products/presentation/widgets/circle_button.dart';

import '../constants/app_colors.dart';

class AppTopBar extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final IconData? icon;
  final Color? iconColor;
  final bool showActions;
  const AppTopBar({
    Key? key,
    this.iconColor,
    required this.title,
    this.icon,
    this.onPressed,
    this.showActions = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 8.h,
      ),
      child: Row(
        children: [
          CircleButton(
            icon: Icons.arrow_back_ios_new_rounded,
            onPressed: () {
              context.pop();
            },
          ),
          const Spacer(),
          Text(
            title,
            style: TextStyle(
              color: AppColors.textPrimaryColor,
              fontSize: 17.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          if (showActions && icon != null && onPressed != null)
            CircleButton(
              icon: icon!,
              iconColor: iconColor,
              onPressed: onPressed!,
            )
          else
            SizedBox(width: 40.w),
        ],
      ),
    );
  }
}
