import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:store/features/products/presentation/widgets/pagination_buttons.dart';
import 'package:store/features/products/presentation/widgets/product_card.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../products/domain/entites/product.dart';
import '../../../products/presentation/bloc/products/products_bloc.dart';
import '../../../products/presentation/bloc/products/products_event.dart';
import '../../../products/presentation/bloc/products/products_state.dart';
import '../../../products/presentation/widgets/error_section.dart';

class ProductsSection extends StatelessWidget {
  const ProductsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoadingState) {
            return const Center(
                child: CircularProgressIndicator(
              color: AppColors.primaryColor,
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
                        onTap: () =>
                            context.push('/product_details/${product.id}'),
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.55,
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
                          GetAllProductsEvent(
                              page: page, searchQuery: state.searchQuery),
                        );
                  },
                ),
              ),
            ]);
          }
          if (state is ProductsFailureState) {
            return ErrorSection(
              message: state.errorMessage,
              onPressed: () =>
                  context.read<ProductsBloc>().add(GetAllProductsEvent()),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
