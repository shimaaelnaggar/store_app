import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/core/constants/app_colors.dart';
import 'package:store/core/constants/app_text_styles.dart';

import '../../../products/presentation/widgets/product_image.dart';
import '../../../products/presentation/widgets/quantity.dart';
import '../../domain/entites/cart_item.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;
  final bool isUpdating;

  const CartItemCard({
    Key? key,
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
    this.isUpdating = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool hasDiscount = item.discountPercentage > 0;

    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.inputBorderColor.withAlpha(10),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDarkColor.withAlpha(10),
            blurRadius: 12.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductImage(
            imageUrl: item.productCoverUrl,
            width: 88,
            height: 100,
            borderRadius: 12,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        item.productName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodyLarge,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    InkWell(
                      onTap: isUpdating ? null : onRemove,
                      borderRadius: BorderRadius.circular(8.r),
                      child: Padding(
                        padding: EdgeInsets.all(4.r),
                        child: Icon(
                          Icons.delete_outline_rounded,
                          size: 21.r,
                          color: AppColors.favouriteColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                if (hasDiscount) ...[
                  Text(
                    '${item.basePricePerUnit.toStringAsFixed(2)} EGP',
                    style: AppTextStyles.bodyMedium.copyWith(
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  SizedBox(height: 2.h),
                ],
                Text(
                  '${item.finalPricePerUnit.toStringAsFixed(2)} EGP',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Quantity(
                      quantity: item.quantity,
                      stock: item.productStock,
                      onIncrement: onIncrease,
                      onDecrement: onDecrease,
                      showLabel: false,
                      isLoading: isUpdating,
                      compact: true,
                      filledButtons: true,
                    ),
                    Flexible(
                      child: Text(
                        '${item.totalPrice.toStringAsFixed(2)} EGP',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
