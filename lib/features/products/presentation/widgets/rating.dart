import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';

class Rating extends StatelessWidget {
  final double rating;
  final int reviewsCount;
  final double? iconSize;
  final double? ratingFontSize;
  final double? reviewsFontSize;

  const Rating({
    Key? key,
    required this.rating,
    required this.reviewsCount,
    this.iconSize,
    this.ratingFontSize,
    this.reviewsFontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star_rounded,
          color: AppColors.ratingColor,
          size: (iconSize ?? 21).sp,
        ),
        SizedBox(width: 5.w),
        Text(
          rating.toStringAsFixed(1),
          style: TextStyle(
            color: AppColors.textPrimaryColor,
            fontSize: (ratingFontSize ?? 14).sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 5.w),
        Text(
          '($reviewsCount reviews)',
          style: TextStyle(
            color: AppColors.textSecondaryColor,
            fontSize: (reviewsFontSize ?? 13).sp,
          ),
        ),
      ],
    );
  }
}
