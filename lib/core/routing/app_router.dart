import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:store/features/adresses/presentation/bloc/addresses_bloc.dart';
import 'package:store/features/auth/presentation/views/login_view.dart';
import 'package:store/features/cart/presentation/views/cart_view.dart';
import 'package:store/features/orders/presentation/views/paymob_checkout_view.dart';
import 'package:store/features/profile/presentation/bloc/profile_bloc.dart';

import '../../features/adresses/presentation/views/address_details_view.dart';
import '../../features/orders/domain/entites/order.dart';
import '../../features/orders/presentation/bloc/order_bloc.dart';
import '../../features/orders/presentation/bloc/order_event.dart';
import '../../features/orders/presentation/views/checkout_view.dart';
import '../../features/adresses/presentation/views/choose_location_view.dart';
import '../../features/auth/presentation/views/sign_up_view.dart';
import '../../features/auth/presentation/views/verify_email_view.dart';
import '../../features/cart/presentation/bloc/cart_bloc.dart';
import '../../features/home/presentation/views/home_view.dart';
import '../../features/orders/presentation/views/order_confirmation_view.dart';
import '../../features/orders/presentation/views/receipt_view.dart';
import '../../features/products/presentation/views/products_details_view.dart';
import '../../features/profile/presentation/views/my_orders_view.dart';
import '../../features/profile/presentation/views/profile_view.dart';
import '../di/service_locator.dart';

class AddressDetailsArgs {
  final LatLng selectedLocation;
  final AddressesBloc addressesBloc;

  const AddressDetailsArgs({
    required this.selectedLocation,
    required this.addressesBloc,
  });
}

class CheckoutArgs {
  final CartBloc cartBloc;
  final AddressesBloc addressesBloc;
  final ProfileBloc profileBloc;

  const CheckoutArgs({
    required this.cartBloc,
    required this.addressesBloc,
    required this.profileBloc,
  });
}

class AppRouter {
  final GoRouter goRouter = GoRouter(
    initialLocation: '/sign-up',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: '/cart',
        builder: (context, state) => const CartView(),
      ),
      GoRoute(
        path: '/product_details/:id',
        builder: (context, state) {
          final String id = state.pathParameters['id']!;
          return ProductsDetailsView(id: id);
        },
      ),
      GoRoute(
        path: '/sign-up',
        builder: (context, state) => const SignUpView(),
      ),
      GoRoute(
        path: '/verify-email',
        builder: (context, state) {
          final email = state.extra as String;

          return VerifyEmailView(
            email: email,
          );
        },
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: '/location',
        builder: (context, state) {
          final addressesBloc = state.extra as AddressesBloc;

          return BlocProvider.value(
            value: addressesBloc,
            child: const ChooseLocationView(),
          );
        },
      ),
      GoRoute(
        path: '/address-details',
        builder: (context, state) {
          final args = state.extra as AddressDetailsArgs;

          return BlocProvider.value(
            value: args.addressesBloc,
            child: AddressDetailsView(
              selectedLocation: args.selectedLocation,
            ),
          );
        },
      ),
      GoRoute(
        path: '/orders',
        builder: (context, state) {
          final args = state.extra as CheckoutArgs;

          return MultiBlocProvider(
            providers: [
              BlocProvider<CartBloc>.value(
                value: args.cartBloc,
              ),
              BlocProvider<AddressesBloc>.value(
                value: args.addressesBloc,
              ),
              BlocProvider<ProfileBloc>.value(
                value: args.profileBloc,
              ),
              BlocProvider<OrderBloc>(
                create: (_) => getIt<OrderBloc>(),
              ),
            ],
            child: const CheckoutView(),
          );
        },
      ),
      GoRoute(
        path: '/paymob-checkout',
        builder: (context, state) {
          final url = state.extra as String;
          return PaymobCheckoutView(checkoutUrl: url);
        },
      ),
      GoRoute(
        path: '/order-confirmation',
        builder: (context, state) {
          final order = state.extra as OrderEntity;

          return OrderConfirmationView(order: order);
        },
      ),
      GoRoute(
        path: '/receipt',
        builder: (context, state) {
          final order = state.extra as OrderEntity;
          return ReceiptView(order: order);
        },
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileView(),
      ),
      GoRoute(
        path: '/my-orders',
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<OrderBloc>()..add(GetOrdersEvent()),
          child: const MyOrdersView(),
        ),
      ),
    ],
  );
}
