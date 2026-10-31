import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:store/core/constants/app_colors.dart';
import 'package:store/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:store/features/cart/presentation/bloc/cart_state.dart';
import 'package:store/features/products/presentation/widgets/circle_button.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 8.h,
      ),
      child: Row(
        children: [
          Text(
            'Store',
            style: TextStyle(
              color: AppColors.textPrimaryColor,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),

// Profile
          CircleButton(
            icon: Icons.person_outline_rounded,
            onPressed: () => context.push('/profile'),
          ),

          SizedBox(width: 8.w),

// Notifications
          CircleButton(
            icon: Icons.notifications_none_rounded,
            onPressed: () => context.push('/notifications'),
          ),

          SizedBox(width: 8.w),

// Cart
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              final cart = context.read<CartBloc>().currentCart;

              final totalQuantity = cart?.cartItems.fold<int>(
                    0,
                    (total, item) => total + item.quantity,
                  ) ??
                  0;

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleButton(
                    icon: Icons.shopping_cart_outlined,
                    onPressed: () => context.push('/cart'),
                  ),
                  if (totalQuantity > 0)
                    Positioned(
                      right: -5,
                      top: -5,
                      child: Container(
                        padding: EdgeInsets.all(4.r),
                        constraints: BoxConstraints(
                          minWidth: 18.r,
                          minHeight: 18.r,
                        ),
                        decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$totalQuantity',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
