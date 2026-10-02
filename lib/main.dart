import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/features/home/presentation/views/home_view.dart';
import 'package:store/features/products/presentation/views/products_details_view.dart';
import 'core/di/service_locator.dart';
import 'core/routing/app_router.dart';
import 'features/products/domain/entites/product.dart';

void main() async {
  setupAppServiceLocator();
  runApp(const StoreApp());
}

class StoreApp extends StatelessWidget {
  const StoreApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Product product;
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: getIt<AppRouter>().goRouter,
      ),
    );
  }
}
