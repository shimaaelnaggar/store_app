import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../domain/entites/product.dart';

class ProductInfo extends StatelessWidget {
  final Product product;
  const ProductInfo({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.inputBorderColor,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _infoItem(
                  icon: Icons.palette_outlined,
                  label: 'Color',
                  value: product.color,
                ),
              ),
              Expanded(
                child: _infoItem(
                  icon: Icons.scale_outlined,
                  label: 'Weight',
                  value: '${product.weight} g',
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _infoItem(
                  icon: Icons.inventory_2_outlined,
                  label: 'Availability',
                  value: product.stock > 0 ? 'In stock' : 'Out of stock',
                ),
              ),
              Expanded(
                child: _infoItem(
                  icon: Icons.qr_code_2_rounded,
                  label: 'Product Code',
                  value: product.productCode,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _infoItem({
  required IconData icon,
  required String label,
  required String value,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(
        icon,
        size: 20.sp,
        color: AppColors.primaryColor,
      ),
      SizedBox(width: 8.w),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: AppColors.textSecondaryColor,
                fontSize: 11.sp,
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              value,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.textPrimaryColor,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
