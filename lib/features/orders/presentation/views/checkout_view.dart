import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:store/core/constants/app_colors.dart';
import 'package:store/core/constants/app_text_styles.dart';
import 'package:store/core/widgets/App_section_title.dart';
import 'package:store/core/widgets/app_card.dart';
import 'package:store/core/widgets/app_top_bar.dart';
import 'package:store/core/widgets/primary_button.dart';
import 'package:store/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:store/features/cart/presentation/bloc/cart_event.dart';
import 'package:store/features/cart/presentation/bloc/cart_state.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/storage/address_selected_storage.dart';
import '../../../adresses/domain/entites/addresses.dart';
import '../../../adresses/presentation/bloc/addresses_bloc.dart';
import '../../../adresses/presentation/bloc/addresses_event.dart';
import '../../../adresses/presentation/bloc/addresses_state.dart';
import '../../../profile/presentation/bloc/profile_bloc.dart';
import '../../../profile/presentation/bloc/profile_event.dart';
import '../../../profile/presentation/bloc/profile_state.dart';
import '../bloc/order_bloc.dart';
import '../bloc/order_event.dart';
import '../bloc/order_state.dart';
import '../widgets/address_card.dart';
import '../widgets/checkout_bottom_bar.dart';
import '../widgets/price_details_section.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({Key? key}) : super(key: key);

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  Addresses? selectedAddress;
  Set<String> _previousOrderIds = {};
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      context.read<ProfileBloc>().add(GetProfileEvent());
    });
  }

  Future<void> _loadSelectedAddress(
    List<Addresses> addresses,
    String userId,
  ) async {
    final storage = getIt<AddressSelectionStorage>();

    final savedAddressId = await storage.getSelectedAddress(
      userId: userId,
    );

    if (!mounted) return;

    final matchedAddress = addresses.where(
      (address) => address.id == savedAddressId,
    );

    setState(() {
      selectedAddress = matchedAddress.isNotEmpty
          ? matchedAddress.first
          : addresses.isNotEmpty
              ? addresses.first
              : null;
    });

    if (savedAddressId == null && selectedAddress?.id != null) {
      await storage.saveSelectedAddress(
        userId: userId,
        addressId: selectedAddress!.id!,
      );
    }
  }

  Future<void> _selectAddress(Addresses address) async {
    final profileState = context.read<ProfileBloc>().state;

    if (profileState is! ProfileSuccessState || address.id == null) {
      return;
    }

    await getIt<AddressSelectionStorage>().saveSelectedAddress(
      userId: profileState.profile.userId,
      addressId: address.id!,
    );

    if (!mounted) return;

    setState(() {
      selectedAddress = address;
    });
  }

  Future<void> _confirmOrder() async {
    if (selectedAddress == null || selectedAddress!.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add a delivery address first.'),
        ),
      );
      return;
    }

    final orderBloc = context.read<OrderBloc>();

    orderBloc.add(GetOrdersEvent());

    final ordersResult = await orderBloc.stream.firstWhere(
      (state) =>
          state is GetOrdersSuccessState || state is GetOrdersFailureState,
    );

    if (!mounted) return;

    if (ordersResult is GetOrdersFailureState) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ordersResult.errorMessage)),
      );
      return;
    }

    final previousOrders = (ordersResult as GetOrdersSuccessState).orders;

    _previousOrderIds = previousOrders.map((order) => order.orderId).toSet();

    orderBloc.add(
      PlaceOrderEvent(
        shippingAddressId: selectedAddress!.id!,
      ),
    );
  }

  Future<void> _verifyPayment() async {
    final orderBloc = context.read<OrderBloc>();

    final ordersFuture = orderBloc.stream.firstWhere(
      (state) =>
          state is GetOrdersSuccessState || state is GetOrdersFailureState,
    );

    orderBloc.add(GetOrdersEvent());

    final ordersState = await ordersFuture;

    if (!mounted) return;

    if (ordersState is GetOrdersFailureState) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ordersState.errorMessage)),
      );

      return;
    }

    final orders = (ordersState as GetOrdersSuccessState).orders;

    final newOrders = orders
        .where(
          (order) => !_previousOrderIds.contains(order.orderId),
        )
        .toList();

    if (newOrders.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Could not find the new order. Please check again.',
          ),
        ),
      );
      return;
    }

    newOrders.sort(
      (a, b) => b.createdAt.compareTo(a.createdAt),
    );

    final newOrder = newOrders.first;

    if (newOrder.status.toLowerCase() == 'processing') {
      context.go(
        '/order-confirmation',
        extra: newOrder,
      );
    } else if (newOrder.status.toLowerCase() == 'pending') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Payment is still being verified. Please try checking again shortly.',
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Order status: ${newOrder.status}',
          ),
        ),
      );
    }
  }

  Future<void> _openPaymentPage(String checkoutUrl) async {
    await context.push(
      '/paymob-checkout',
      extra: checkoutUrl,
    );

    if (!mounted) return;

    await _verifyPayment();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderBloc, OrderState>(
      listener: (context, state) {
        if (state is OrderLoadingState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Placing order...'),
            ),
          );
        } else if (state is OrderFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
            ),
          );
        } else if (state is OrderSuccessState) {
          _openPaymentPage(state.response.unifiedCheckoutUrl);
        }
      },
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileSuccessState) {
            debugPrint('Current user ID: ${state.profile.userId}');

            context.read<AddressesBloc>().add(GetAddressesEvent());
          }
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.backgroundColor,
            body: Column(
              children: [
                const AppTopBar(
                  title: 'Checkout',
                  iconColor: AppColors.textSecondaryColor,
                  showActions: false,
                ),
                Expanded(
                  child: BlocBuilder<CartBloc, CartState>(
                    builder: (context, cartState) {
                      if (cartState is GetCartLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        );
                      }

                      if (cartState is GetCartFailureState) {
                        return Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(cartState.errorMessage),
                              SizedBox(height: 12.h),
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

                      if (cartState is! GetCartSuccessState) {
                        return const Center(
                          child: Text('Loading orders...'),
                        );
                      }

                      final items = cartState.cartResponse.cartItems;
                      final subtotal = items.fold<double>(
                        0,
                        (sum, item) => sum + item.totalPrice,
                      );
                      final orderState = context.watch<OrderBloc>().state;
                      if (items.isEmpty) {
                        return const Center(
                          child: Text('Your cart is empty'),
                        );
                      }

                      return Column(
                        children: [
                          Expanded(
                            child: ListView(
                              padding: EdgeInsets.all(16.r),
                              children: [
                                const AppSectionTitle(
                                    title: 'Delivery Address'),
                                SizedBox(height: 10.h),
                                BlocConsumer<AddressesBloc, AddressesState>(
                                    listener: (context, state) async {
                                  if (state is AddressesSuccessState) {
                                    final profileState =
                                        context.read<ProfileBloc>().state;

                                    if (profileState is ProfileSuccessState) {
                                      await _loadSelectedAddress(
                                        state.addressesList,
                                        profileState.profile.userId,
                                      );
                                    }
                                  }
                                }, builder: (context, state) {
                                  if (state is AddressesLoadingState) {
                                    return const AppCard(
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                    );
                                  }

                                  if (state is AddressesFailureState) {
                                    return AppCard(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Could not load your addresses.',
                                          ),
                                          SizedBox(height: 8.h),
                                          Text(
                                            state.errorMessage,
                                            style: AppTextStyles.bodyMedium,
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              context
                                                  .read<AddressesBloc>()
                                                  .add(GetAddressesEvent());
                                            },
                                            child: const Text('Retry'),
                                          ),
                                        ],
                                      ),
                                    );
                                  }

                                  final addresses =
                                      state is AddressesSuccessState
                                          ? state.addressesList
                                          : <Addresses>[];

                                  if (selectedAddress != null) {
                                    return AddressCard(
                                      onPressed: () async {
                                        final address =
                                            await context.push<Addresses>(
                                          '/location',
                                          extra: context.read<AddressesBloc>(),
                                        );

                                        if (!mounted || address == null) return;

                                        await _selectAddress(address);
                                      },
                                      address: selectedAddress!,
                                    );
                                  }

                                  if (addresses.isEmpty) {
                                    return AppCard(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'No delivery address selected.',
                                          ),
                                          SizedBox(height: 8.h),
                                          const Text(
                                            'Add an address to continue.',
                                          ),
                                          SizedBox(height: 12.h),
                                          PrimaryButton(
                                            label: 'Add Address',
                                            onPressed: () async {
                                              final address =
                                                  await context.push<Addresses>(
                                                '/location',
                                                extra: context
                                                    .read<AddressesBloc>(),
                                              );

                                              if (!mounted || address == null) {
                                                return;
                                              }

                                              await _selectAddress(address);
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                  return AddressCard(
                                    address: addresses.first,
                                    onPressed: () async {
                                      final address =
                                          await context.push<Addresses>(
                                        '/location',
                                        extra: context.read<AddressesBloc>(),
                                      );
                                      if (!mounted || address == null) return;

                                      await _selectAddress(address);
                                    },
                                  );
                                }),
                                SizedBox(height: 24.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const AppSectionTitle(
                                        title: 'Order Summary'),
                                    TextButton(
                                      onPressed: () => context.pop(),
                                      child: const Text('View Cart'),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.h),
                                AppCard(
                                  child: Column(
                                    children: [
                                      for (int i = 0;
                                          i < items.length;
                                          i++) ...[
                                        if (i > 0) ...[
                                          SizedBox(height: 12.h),
                                          Divider(
                                            color: AppColors.inputBorderColor
                                                .withAlpha(100),
                                          ),
                                          SizedBox(height: 12.h),
                                        ],
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 64.w,
                                              height: 70.h,
                                              decoration: BoxDecoration(
                                                color: AppColors.inputFillColor,
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                              ),
                                              clipBehavior: Clip.antiAlias,
                                              child: Image.network(
                                                items[i].productCoverUrl,
                                                fit: BoxFit.contain,
                                                errorBuilder: (_, __, ___) =>
                                                    Icon(
                                                  Icons
                                                      .image_not_supported_outlined,
                                                  color: AppColors
                                                      .textSecondaryColor,
                                                  size: 24.r,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 12.w),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    items[i].productName,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        AppTextStyles.bodyLarge,
                                                  ),
                                                  SizedBox(height: 6.h),
                                                  Text(
                                                    'Qty: ${items[i].quantity}',
                                                    style: AppTextStyles
                                                        .bodyMedium,
                                                  ),
                                                  SizedBox(height: 6.h),
                                                  Text(
                                                    '${items[i].totalPrice.toStringAsFixed(2)} EGP',
                                                    style: AppTextStyles
                                                        .bodyLarge
                                                        .copyWith(
                                                      color: AppColors
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                                SizedBox(height: 24.h),
                                const AppSectionTitle(title: 'Price Details'),
                                SizedBox(height: 10.h),
                                AppCard(
                                  child: PriceDetailsSection(
                                    subtotal: subtotal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CheckoutBottomBar(
                            total: subtotal,
                            onConfirmOrder: _confirmOrder,
                            isLoading: orderState is OrderLoadingState ||
                                orderState is GetOrdersLoadingState,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
