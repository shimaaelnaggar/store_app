import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:store/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:store/features/cart/presentation/bloc/cart_event.dart';
import 'package:store/features/cart/presentation/bloc/cart_state.dart';
import 'package:store/core/widgets/app_top_bar.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/routing/app_router.dart';
import '../../../adresses/presentation/bloc/addresses_bloc.dart';
import '../../../profile/presentation/bloc/profile_bloc.dart';
import '../widgets/cart_bottom_bar.dart';
import '../widgets/cart_item_card.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Column(
          children: [
            const AppTopBar(
              iconColor: AppColors.textSecondaryColor,
              title: 'My Cart',
              showActions: false,
            ),
            Expanded(
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is GetCartLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    );
                  }

                  if (state is GetCartFailureState) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(state.errorMessage),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () {
                              context.read<CartBloc>().add(GetCartEvent());
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is GetCartSuccessState) {
                    final items = state.cartResponse.cartItems;

                    if (items.isEmpty) {
                      return const Center(
                        child: Text('Your cart is empty'),
                      );
                    }

                    return Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            padding: EdgeInsets.all(16.r),
                            itemCount: items.length,
                            separatorBuilder: (_, __) => SizedBox(height: 12.h),
                            itemBuilder: (context, index) {
                              final item = items[index];

                              return CartItemCard(
                                key: ValueKey(item.itemId),
                                item: item,
                                isUpdating: state.updatingItemId == item.itemId,
                                onIncrease: () {
                                  if (item.quantity < item.productStock) {
                                    context.read<CartBloc>().add(
                                          UpdateCartItemQuantityEvent(
                                            itemId: item.itemId,
                                            quantity: item.quantity + 1,
                                          ),
                                        );
                                  }
                                },
                                onDecrease: () {
                                  if (item.quantity > 1) {
                                    context.read<CartBloc>().add(
                                          DecrementCartItemQuantityEvent(
                                            itemId: item.itemId,
                                            quantity: 1,
                                          ),
                                        );
                                  }
                                },
                                onRemove: () {
                                  context.read<CartBloc>().add(
                                        RemoveCartItemEvent(
                                          itemId: item.itemId,
                                        ),
                                      );
                                },
                              );
                            },
                          ),
                        ),
                        CartBottomBar(
                          totalPrice: items.fold<double>(
                            0,
                            (sum, item) => sum + item.totalPrice,
                          ),
                          totalItems: items.fold<int>(
                            0,
                            (sum, item) => sum + item.quantity,
                          ),
                          onCheckout: () {
                            context.push(
                              '/orders',
                              extra: CheckoutArgs(
                                cartBloc: context.read<CartBloc>(),
                                addressesBloc: getIt<AddressesBloc>(),
                                profileBloc: getIt<ProfileBloc>(),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  }

                  return const Center(
                    child: Text('Your cart'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
