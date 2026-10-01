
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:store/features/products/presentation/widgets/circle_button.dart';

import '../../../../core/constants/app_colors.dart';

class TopBar extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onPressed;
  const TopBar({Key? key, required this.isFavorite, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
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
            'Product Details',
            style: TextStyle(
              color: AppColors.textPrimaryColor,
              fontSize: 17.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          CircleButton(
            icon: isFavorite
                ? Icons.favorite_rounded
                : Icons.favorite_border_rounded,
            iconColor: isFavorite
                ? AppColors.favouriteColor
                : AppColors.textPrimaryColor,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
