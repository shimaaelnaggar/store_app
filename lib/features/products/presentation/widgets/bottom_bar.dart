import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';

class ProductBottomBar extends StatelessWidget {
  final double totalPrice;
  final int stock;
  final VoidCallback? onAddToCart;

  const ProductBottomBar({
    Key? key,
    required this.totalPrice,
    required this.stock,
    this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isOutOfStock = stock == 0;

    return Container(
      padding: EdgeInsets.fromLTRB(
        16.w,
        12.h,
        16.w,
        14.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.08),
            blurRadius: 15,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    color: AppColors.textSecondaryColor,
                    fontSize: 11.sp,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  '\$${totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: AppColors.textPrimaryColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: SizedBox(
                height: 52.h,
                child: ElevatedButton.icon(
                  onPressed: isOutOfStock ? null : onAddToCart,
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    size: 20.sp,
                  ),
                  label: Text(
                    isOutOfStock ? 'Out of Stock' : 'Add to Cart',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: AppColors.inputBorderColor,
                    disabledForegroundColor: AppColors.textSecondaryColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
