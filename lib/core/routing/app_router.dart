import 'package:go_router/go_router.dart';
import 'package:store/features/auth/presentation/views/login_view.dart';

import '../../features/auth/presentation/views/sign_up_view.dart';
import '../../features/auth/presentation/views/verify_email_view.dart';
import '../../features/home/presentation/views/home_view.dart';
import '../../features/products/presentation/views/products_details_view.dart';

class AppRouter {
  final GoRouter goRouter = GoRouter(
    initialLocation: '/sign-up',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeView(),
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
    ],
  );
}
