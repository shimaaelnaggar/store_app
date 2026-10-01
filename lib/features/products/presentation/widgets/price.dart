import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/helper/calculate_discount_price.dart';

class Price extends StatelessWidget {
  final double price;
  final int discountPercentage;

  const Price({
    Key? key,
    required this.price,
    required this.discountPercentage,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool hasDiscount = discountPercentage > 0;

    final double discountedPrice = calculateDiscountedPrice(
      price: price,
      discountPercentage: discountPercentage,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '\$${discountedPrice.toStringAsFixed(2)}',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 26.sp,
                fontWeight: FontWeight.w800,
              ),
            ),

            if (hasDiscount) ...[
              SizedBox(width: 10.w),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 5.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.favouriteColor.withOpacity(.1),
                  borderRadius: BorderRadius.circular(7.r),
                ),
                child: Text(
                  '$discountPercentage% OFF',
                  style: TextStyle(
                    color: AppColors.favouriteColor,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ],
        ),

        if (hasDiscount) ...[
          SizedBox(height: 4.h),
          Text(
            '\$${price.toStringAsFixed(2)}',
            style: TextStyle(
              color: AppColors.textSecondaryColor,
              fontSize: 14.sp,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ],
    );
  }
}
