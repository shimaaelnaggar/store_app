import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class Quantity extends StatelessWidget {
  final int quantity;
  final int stock;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const Quantity({
    Key? key,
    required this.quantity,
    required this.stock,
    required this.onIncrement,
    required this.onDecrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final canDecrease = quantity > 1;
    final canIncrease = quantity < stock;

    return Row(
      children: [
        Text(
          'Quantity',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textPrimaryColor,
          ),
        ),
        const Spacer(),
        Container(
          decoration: BoxDecoration(
            color: AppColors.inputFillColor,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              _quantityButton(
                icon: Icons.remove_rounded,
                enabled: canDecrease,
                onPressed: canDecrease ? onDecrement : null,
              ),
              SizedBox(
                width: 42.w,
                child: Center(
                  child: Text(
                    '$quantity',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                ),
              ),
              _quantityButton(
                icon: Icons.add_rounded,
                enabled: canIncrease,
                onPressed: canIncrease ? onIncrement : null,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _quantityButton({
    required IconData icon,
    required bool enabled,
    required VoidCallback? onPressed,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: 20.sp,
        color: enabled ? AppColors.primaryColor : AppColors.textSecondaryColor,
      ),
    );
  }
}
