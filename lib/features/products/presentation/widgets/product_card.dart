import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/core/constants/app_colors.dart';
import 'package:store/core/constants/app_spacing.dart';
import 'package:store/core/constants/app_text_styles.dart';
import 'package:store/features/products/presentation/widgets/rating.dart';

import '../../../../core/helper/calculate_discount_price.dart';

class ProductCard extends StatelessWidget {
  final String imgUrl;
  final String categoryName;
  final String title;
  final double rate;
  final int reviewsCount;
  final int discountPercentage;
  final int stock;
  final double price;
  final void Function()? onPressed;
  final void Function()? onTap;
  const ProductCard({
    Key? key,
    required this.imgUrl,
    required this.categoryName,
    required this.title,
    required this.rate,
    required this.price,
    required this.onPressed,
    required this.reviewsCount,
    required this.discountPercentage,
    required this.stock,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isOutOfStock = stock <= 0;
    final bool hasDiscount = discountPercentage > 0;
    final double discountedPrice = calculateDiscountedPrice(
      price: price,
      discountPercentage: discountPercentage,
    );

    return InkWell(
      onTap: onTap,
      child: Card(
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
                    ),
                    child: CachedNetworkImage(
                      imageUrl: imgUrl,
                      height: 120.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        );
                      },
                      errorWidget: (context, url, error) {
                        return Image.asset(
                          'assets/images/product_placeholder.jpg',
                          fit: BoxFit.cover,
                        );
                      },
                    )),
              ),
              const SizedBox(
                height: AppSpacing.sm,
              ),
              Text(
                categoryName.toUpperCase(),
                style: AppTextStyles.bodyMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                title,
                style: AppTextStyles.bodyRegular,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.sm),
              Rating(rating: rate, reviewsCount: reviewsCount),
              const SizedBox(height: AppSpacing.sm),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (hasDiscount)
                        Text(
                          '\$${price.toStringAsFixed(2)}',
                          style: AppTextStyles.bodyMedium.copyWith(
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Text(
                        '\$${discountedPrice.toStringAsFixed(2)}',
                        style: AppTextStyles.bodyLarge,
                      ),
                    ],
                  ),
                  Container(
                    height: 40.h,
                    width: 40.w,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: isOutOfStock ? null : onPressed,
                      icon: Icon(
                        Icons.add_shopping_cart,
                        color: AppColors.secondaryColor,
                        size: 20.r,
                      ),
                    ),
                  ),
                ],
              ),
              if (isOutOfStock) ...[
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Out of stock',
                  style: AppTextStyles.bodyMedium,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
