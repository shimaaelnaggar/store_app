import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class Quantity extends StatelessWidget {
  final int quantity;
  final int stock;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final bool showLabel;
  final bool isLoading;
  final bool compact;
  final bool filledButtons;
  const Quantity({
    Key? key,
    required this.quantity,
    required this.stock,
    required this.onIncrement,
    required this.onDecrement,
    this.showLabel = true,
    this.isLoading = false,
    this.compact = false,
    this.filledButtons = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final canDecrease = quantity > 1 && !isLoading;
    final canIncrease = quantity < stock && !isLoading;

    return Row(
      children: [
        if (showLabel) ...[
          Text(
            'Quantity',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textPrimaryColor,
            ),
          ),
          const Spacer(),
        ],
        Container(
          padding: EdgeInsets.all(compact ? 3.r : 0),
          decoration: BoxDecoration(
            color: AppColors.inputFillColor,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _quantityButton(
                icon: Icons.remove_rounded,
                enabled: canDecrease,
                onPressed: canDecrease ? onDecrement : null,
              ),
              SizedBox(
                width: compact ? 30.w : 42.w,
                child: Center(
                  child: isLoading
                      ? SizedBox(
                          width: 14.r,
                          height: 14.r,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.primaryColor,
                          ),
                        )
                      : Text(
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
    final buttonSize = compact ? 28.0 : 40.0;
    return Material(
      color: filledButtons ? AppColors.surfaceColor : Colors.transparent,
      borderRadius: BorderRadius.circular(compact ? 7.r : 10.r),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(compact ? 7.r : 10.r),
        child: SizedBox(
          width: buttonSize.w,
          height: buttonSize.h,
          child: Icon(
            icon,
            size: compact ? 17.r : 20.r,
            color: enabled
                ? AppColors.primaryColor
                : AppColors.textSecondaryColor.withAlpha(90),
          ),
        ),
      ),
    );
  }
}
