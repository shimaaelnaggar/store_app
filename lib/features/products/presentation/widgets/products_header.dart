import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/core/constants/app_spacing.dart';
import 'package:store/core/constants/app_text_styles.dart';

import '../../../../core/constants/app_colors.dart';

class ProductsHeader extends StatelessWidget {
  final int productsCount;
  const ProductsHeader({Key? key, required this.productsCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: Row(
        children: [
          Text(
            'All Products',
            style: AppTextStyles.bodyLarge,
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: AppColors.productsCountBackgroundColor,

              borderRadius: BorderRadius.circular(AppSpacing.md),
            ),
            child: Text(
              '$productsCount items',
              style: const TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
