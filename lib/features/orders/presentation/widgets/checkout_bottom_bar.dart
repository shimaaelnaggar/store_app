import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/core/widgets/primary_button.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class CheckoutBottomBar extends StatelessWidget {
  final double total;
  final VoidCallback onConfirmOrder;
  final bool isLoading;
  const CheckoutBottomBar(
      {Key? key,
      required this.total,
      required this.onConfirmOrder,
      this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDarkColor.withAlpha(10),
            blurRadius: 16.r,
            offset: Offset(0, -4.h),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Grand Total',
                  style: AppTextStyles.bodyMedium,
                ),
                SizedBox(height: 4.h),
                Text(
                  '${total.toStringAsFixed(2)} EGP',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: PrimaryButton(
              label: isLoading ? 'Placing Order...' : 'Confirm Order',
              onPressed: isLoading ? null : onConfirmOrder,
            ),
          ),
        ],
      ),
    );
  }
}
