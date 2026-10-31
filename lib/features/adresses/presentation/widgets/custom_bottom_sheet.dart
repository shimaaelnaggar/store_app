import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class CustomBottomSheet extends StatelessWidget {
  final String location;
  final VoidCallback onConfirm;
  const CustomBottomSheet(
      {Key? key, required this.location, required this.onConfirm})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        16.w,
        16.h,
        16.w,
        20.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22.r),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x18000000),
            blurRadius: 16,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.inputBorderColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Your location',
            style: AppTextStyles.bodyLarge,
          ),
          SizedBox(height: 4.h),
          Text(
            'Move the map to adjust the pin',
            style: AppTextStyles.bodyRegular.copyWith(
              color: AppColors.textSecondaryColor,
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: AppColors.inputFillColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: AppColors.primaryColor,
                  size: 28.sp,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selected map point',
                        style: AppTextStyles.bodyRegular,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        location,
                        style: AppTextStyles.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: onConfirm,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: AppColors.secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Confirm Location',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.secondaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
