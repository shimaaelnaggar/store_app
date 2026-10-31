import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/app_top_bar.dart';
import '../../../orders/domain/entites/order.dart';
import '../../../orders/presentation/bloc/order_bloc.dart';
import '../../../orders/presentation/bloc/order_event.dart';
import '../../../orders/presentation/bloc/order_state.dart';

class MyOrdersView extends StatelessWidget {
  const MyOrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            children: [
              const AppTopBar(title: 'My Orders'),
              SizedBox(height: 20.h),
              Expanded(
                child: BlocBuilder<OrderBloc, OrderState>(
                  builder: (context, state) {
                    if (state is GetOrdersLoadingState ||
                        state is OrderInitialState) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      );
                    }

                    if (state is GetOrdersFailureState) {
                      return _buildMessage(
                        message: state.errorMessage,
                        action: TextButton(
                          onPressed: () {
                            context.read<OrderBloc>().add(GetOrdersEvent());
                          },
                          child: const Text('Retry'),
                        ),
                      );
                    }

                    if (state is GetOrdersSuccessState) {
                      if (state.orders.isEmpty) {
                        return _buildMessage(
                          message: 'You have no orders yet.',
                          icon: Icons.shopping_bag_outlined,
                        );
                      }

                      return ListView.separated(
                        itemCount: state.orders.length,
                        separatorBuilder: (_, __) => SizedBox(height: 12.h),
                        itemBuilder: (context, index) {
                          return _buildOrderCard(
                            context,
                            state.orders[index],
                          );
                        },
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context, OrderEntity order) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.inputBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  order.orderCode,
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildStatus(order.status),
            ],
          ),
          SizedBox(height: 12.h),
          _infoRow(
            'Date',
            '${order.createdAt.day.toString().padLeft(2, '0')}/'
                '${order.createdAt.month.toString().padLeft(2, '0')}/'
                '${order.createdAt.year}',
          ),
          _infoRow('Payment', order.paymentMethod),
          Divider(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: AppTextStyles.bodyMedium,
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
          SizedBox(height: 12.h),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primaryColor,
                side: const BorderSide(color: AppColors.primaryColor),
              ),
              onPressed: () {
                context.push('/receipt', extra: order);
              },
              child: const Text('View Receipt',
                  style: TextStyle(color: AppColors.primaryColor)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatus(String status) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 5.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.inputFillColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        status,
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.primaryColor,
          fontSize: 12.sp,
        ),
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondaryColor,
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: AppTextStyles.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage({
    required String message,
    IconData? icon,
    Widget? action,
  }) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Icon(
              icon,
              size: 48.r,
              color: AppColors.textSecondaryColor,
            ),
          SizedBox(height: 12.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium,
          ),
          if (action != null) action,
        ],
      ),
    );
  }
}
