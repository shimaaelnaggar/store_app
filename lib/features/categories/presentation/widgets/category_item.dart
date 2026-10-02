import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryItem({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 9.h,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : AppColors.inputFillColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          title,
          style: AppTextStyles.bodyMedium.copyWith(
            color: isSelected
                ? AppColors.secondaryColor
                : AppColors.textPrimaryColor,
          ),
        ),
      ),
    );
  }
}
