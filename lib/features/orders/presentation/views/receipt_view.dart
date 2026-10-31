import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/core/constants/app_colors.dart';
import 'package:store/core/constants/app_text_styles.dart';
import 'package:store/core/widgets/app_top_bar.dart';
import 'package:store/features/orders/domain/entites/order.dart';

class ReceiptView extends StatelessWidget {
  final OrderEntity order;

  const ReceiptView({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.r),
          child: Column(
            children: [
              const AppTopBar(title: 'Receipt'),
              SizedBox(height: 16.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  color: AppColors.surfaceColor,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: AppColors.inputBorderColor,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.receipt_long_rounded,
                      size: 48.r,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'STORE',
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Payment Receipt',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondaryColor,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    const Divider(),
                    _receiptRow(
                      'Order Number',
                      order.orderCode,
                    ),
                    _receiptRow(
                      'Order ID',
                      order.orderId,
                    ),
                    _receiptRow(
                      'Date',
                      _formatDate(order.createdAt),
                    ),
                    _receiptRow(
                      'Time',
                      _formatTime(order.createdAt),
                    ),
                    Divider(height: 28.h),
                    _receiptRow(
                      'Payment Method',
                      order.paymentMethod,
                    ),
                    _receiptRow(
                      'Order Status',
                      order.status,
                    ),
                    Divider(height: 28.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Amount',
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${order.totalPrice.toStringAsFixed(2)} EGP',
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 28.h),
                    Text(
                      'Thank you for shopping with us!',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondaryColor,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Keep this receipt for your records.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _receiptRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 9.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondaryColor,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
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

  String _formatTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }
}
