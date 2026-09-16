import 'package:flutter/material.dart';
import 'package:store/core/di/service_locator.dart';
import 'package:store/views/home_view.dart';
import 'package:store/views/update_product_view.dart';

void main() async {
  setupAppServiceLocator();
  runApp(const StoreApp());
}

class StoreApp extends StatelessWidget {
  const StoreApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeView.id: (context) => const HomeView(),
        // UpdateProductView.id: (context) => const UpdateProductView(),
      },
      initialRoute: HomeView.id,
    );
  }
}
