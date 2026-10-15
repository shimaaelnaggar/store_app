import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/core/constants/app_colors.dart';
import 'package:store/core/constants/app_spacing.dart';
import 'package:store/core/di/service_locator.dart';
import 'package:store/features/categories/presentation/widgets/categories_section.dart';
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
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
            return Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                children: [
                  const ProductsSearchField(),
                   SizedBox(height: 12.h),
                  SizedBox(
                    height: 40.h,
                    child: const CategoriesSection(),
                  ),

                  const ProductsCountSection(),
                  const ProductsSection(),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
