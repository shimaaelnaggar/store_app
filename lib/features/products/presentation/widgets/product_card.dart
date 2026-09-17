import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/core/constants/app_colors.dart';
import 'package:store/core/constants/app_spacing.dart';
import 'package:store/core/constants/app_text_styles.dart';

class ProductCard extends StatelessWidget {
  final String imgUrl;
  final String categoryName;
  final String title;
  final double rate;
  final double price;
  final int ratingCount;
  final void Function()? onPressed;
  const ProductCard(
      {Key? key,
      required this.imgUrl,
      required this.categoryName,
      required this.title,
      required this.rate,
      required this.price,
      required this.onPressed,
      required this.ratingCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.secondaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.lg),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xs),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.xs),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.textSecodaryColor),
                child: Image.network(
                  imgUrl,
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: 120.h,
                ),
              ),
            ),
            const SizedBox(
              height: AppSpacing.sm,
            ),
            Text(categoryName.toUpperCase(), style: AppTextStyles.bodyMedium),
            const SizedBox(height: AppSpacing.xs),
            Text(
              title,
              style: AppTextStyles.bodyRegular,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: AppColors.ratingColor,
                ),
                SizedBox(width: 2.w),
                Text(rate.toString(), style: AppTextStyles.bodySemiBold),
                const SizedBox(width: AppSpacing.xs),
                Text('($ratingCount)', style: AppTextStyles.bodyMedium),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$$price',
                  style: AppTextStyles.bodyLarge,
                ),
                Container(
                  height: 28.h,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                      onPressed: onPressed,
                      icon: Icon(
                        Icons.add_shopping_cart,
                        color: AppColors.secondaryColor,
                        size: 20.r,
                      )),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
