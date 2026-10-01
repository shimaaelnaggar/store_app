import 'package:go_router/go_router.dart';

import '../../features/products/presentation/views/home_view.dart';
import '../../features/products/presentation/views/products_details_view.dart';

class AppRouter {
  final GoRouter goRouter = GoRouter(initialLocation: '/', routes: [
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
  ]);
}
