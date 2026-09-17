import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/constants/app_colors.dart';
import 'package:store/core/constants/app_spacing.dart';
import 'package:store/core/di/service_locator.dart';
import 'package:store/features/products/domain/entites/product.dart';
import 'package:store/features/products/presentation/bloc/products_bloc.dart';
import 'package:store/features/products/presentation/bloc/products_event.dart';
import 'package:store/features/products/presentation/bloc/products_state.dart';
import 'package:store/features/products/presentation/widgets/product_card.dart';
import 'package:store/features/products/presentation/widgets/products_header.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => getIt<ProductsBloc>()..add(GetAllProductsEvent()),
        child: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoadingState) {
              return const Center(
                  child: CircularProgressIndicator(
                color: AppColors.itemsNumberColor,
              ));
            }
            if (state is ProductsSuccessState) {
              final List<Product> products = state.products;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                      child: ProductsHeader(
                        productsCount: products.length,
                      ),
                    ),
                    const SizedBox(
                      height: AppSpacing.sm,
                    ),
                    GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.6,
                          crossAxisSpacing: AppSpacing.sm,
                          mainAxisSpacing: AppSpacing.sm,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];

                          return ProductCard(
                            imgUrl: product.image,
                            categoryName: product.category,
                            title: product.title,
                            rate: product.rating.rate,
                            price: product.price,
                            onPressed: () {},
                            ratingCount: product.rating.count,
                          );
                        }),
                  ],
                ),
              );
            }
            if (state is ProductsFailureState) {
              return Center(child: Text(state.errorMessage));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
