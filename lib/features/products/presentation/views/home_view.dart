import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/constants/app_colors.dart';
import 'package:store/core/constants/app_spacing.dart';
import 'package:store/core/di/service_locator.dart';
import 'package:store/features/products/domain/entites/product.dart';
import 'package:store/features/products/presentation/bloc/products_bloc.dart';
import 'package:store/features/products/presentation/bloc/products_event.dart';
import 'package:store/features/products/presentation/bloc/products_state.dart';
import 'package:store/features/products/presentation/widgets/pagination_buttons.dart';
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
        child: Column(
          children: [
            BlocSelector<ProductsBloc, ProductsState, int>(
              selector: (state) {
                if (state is ProductsSuccessState) {
                  return state.totalCount;
                }
                return 0;
              },
              builder: (context, totalCount) {
                return ProductsHeader(
                  productsCount: totalCount,
                );
              },
            ),
            Expanded(
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
                    return CustomScrollView(slivers: [
                      SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final product = products[index];

                              return ProductCard(
                                imgUrl: product.coverPictureUrl,
                                categoryName: product.categories.isNotEmpty
                                    ? product.categories.first
                                    : '',
                                title: product.name,
                                rate: product.rating,
                                price: product.price,
                                discountPercentage: product.discountPercentage,
                                reviewsCount: product.reviewsCount,
                                stock: product.stock,
                                onPressed: () {},
                              );
                            },
                            childCount: products.length,
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.6,
                            crossAxisSpacing: AppSpacing.sm,
                            mainAxisSpacing: AppSpacing.sm,
                          )),
                      SliverToBoxAdapter(
                        child: PaginationButtons(
                          currentPage: state.page,
                          hasNextPage: state.hasNextPage,
                          hasPreviousPage: state.hasPreviousPage,
                          totalCount: state.totalCount,
                          pageSize: 10,
                          onPageChanged: (page) {
                            context.read<ProductsBloc>().add(
                                  GetAllProductsEvent(page: page),
                                );
                          },
                        ),
                      ),
                    ]);
                  }
                  if (state is ProductsFailureState) {
                    return Center(child: Text(state.errorMessage));
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
