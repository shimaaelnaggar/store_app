import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/constants/app_spacing.dart';
import 'package:store/core/di/service_locator.dart';
import 'package:store/features/products/presentation/bloc/products/products_bloc.dart';
import 'package:store/features/products/presentation/bloc/products/products_event.dart';

import '../../../categories/presentation/bloc/categories_bloc.dart';
import '../../../categories/presentation/bloc/categories_event.dart';
import '../widgets/products_count_section.dart';
import '../widgets/products_search_field.dart';
import '../widgets/products_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                getIt<CategoriesBloc>()..add(GetCategoriesEvent()),
          ),
          BlocProvider(
            create: (context) =>
                getIt<ProductsBloc>()..add(GetAllProductsEvent()),
          ),
        ],
        child: Builder(builder: (context) {
          return const Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: Column(
              children: [
                ProductsSearchField(),
                ProductsCountSection(),
                ProductsSection(),
              ],
            ),
          );
        }),
      ),
    );
  }
}
