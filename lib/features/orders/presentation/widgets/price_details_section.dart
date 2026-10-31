import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class PriceDetailsSection extends StatelessWidget {
  final double subtotal;
  const PriceDetailsSection({
    Key? key,
    required this.subtotal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildPriceRow(
          label: 'Subtotal',
          value: '${subtotal.toStringAsFixed(2)} EGP',
        ),
        SizedBox(height: 12.h),
        Divider(
          color: AppColors.inputBorderColor.withAlpha(100),
        ),
        SizedBox(height: 12.h),
        _buildPriceRow(
          label: 'Total',
          value: '${subtotal.toStringAsFixed(2)} EGP',
          isTotal: true,
        ),
      ],
    );
  }

  Row _buildPriceRow(
          {required String label,
          required String value,
          bool isTotal = false}) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: AppTextStyles.bodyLarge.copyWith(
              color: isTotal ? AppColors.primaryColor : null,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      );
}
