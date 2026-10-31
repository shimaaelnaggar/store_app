import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:store/core/constants/app_colors.dart';
import 'package:store/core/constants/app_text_styles.dart';
import 'package:store/features/orders/domain/entites/order.dart';

import '../../../../core/widgets/primary_button.dart';

class OrderConfirmationView extends StatelessWidget {
  final OrderEntity order;

  const OrderConfirmationView({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            children: [
              const Spacer(),
              Container(
                width: 90.r,
                height: 90.r,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle_rounded,
                  size: 60.r,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                'Order Confirmed!',
                style: AppTextStyles.bodyLarge,
              ),
              SizedBox(height: 8.h),
              Text(
                'Your payment was successful.',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondaryColor,
                ),
              ),
              SizedBox(height: 32.h),
              _buildOrderDetails(),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  label: 'View Receipt',
                  onPressed: () {
                    context.push(
                      '/receipt',
                      extra: order,
                    );
                  },
                ),
              ),
              SizedBox(height: 12.h),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryColor,
                    side: const BorderSide(color: AppColors.primaryColor),
                  ),
                  onPressed: () {
                    context.go('/');
                  },
                  child: const Text(
                    'Continue Shopping',
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderDetails() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.inputBorderColor,
        ),
      ),
      child: Column(
        children: [
          _detailRow('Order number', order.orderCode),
          _detailRow('Order date', _formatDate(order.createdAt)),
          _detailRow('Payment method', order.paymentMethod),
          _detailRow('Order status', order.status),
          Divider(height: 24.h),
          _detailRow(
            'Total paid',
            '${order.totalPrice.toStringAsFixed(2)} EGP',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _detailRow(
    String label,
    String value, {
    bool isTotal = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondaryColor,
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
                color: isTotal
                    ? AppColors.primaryColor
                    : AppColors.textPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}
