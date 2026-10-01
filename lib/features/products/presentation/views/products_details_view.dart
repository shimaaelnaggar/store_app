import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/features/products/presentation/widgets/error_section.dart';
import 'package:store/features/products/presentation/widgets/categories_badge.dart';
import 'package:store/features/products/presentation/widgets/price.dart';
import 'package:store/features/products/presentation/widgets/product_image.dart';
import 'package:store/features/products/presentation/widgets/rating.dart';
import 'package:store/features/products/presentation/widgets/top_bar.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/helper/calculate_discount_price.dart';
import '../bloc/products_details/products_details_bloc.dart';
import '../bloc/products_details/products_details_event.dart';
import '../bloc/products_details/products_details_state.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/product_info.dart';
import '../widgets/quantity.dart';

class ProductsDetailsView extends StatefulWidget {
  final String id;

  const ProductsDetailsView({Key? key, required this.id}) : super(key: key);

  @override
  State<ProductsDetailsView> createState() => _ProductsDetailsViewState();
}

class _ProductsDetailsViewState extends State<ProductsDetailsView> {
  int quantity = 1;
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: BlocProvider<ProductsDetailsBloc>(
        create: (context) => getIt<ProductsDetailsBloc>()
          ..add(
            GetSingleProductEvent(
              id: widget.id,
            ),
          ),
        child: BlocBuilder<ProductsDetailsBloc, ProductsDetailsStates>(
          builder: (context, state) {
            if (state is ProductsDetailsLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              );
            }

            if (state is ProductsDetailsFailure) {
              return ErrorSection(
                  message: state.errorMessage,
                  onPressed: () => GetSingleProductEvent(id: widget.id));
            }

            if (state is ProductsDetailsSuccess) {
              final product = state.product;

              if (product.stock == 0 && quantity != 0) {
                quantity = 0;
              }

              if (product.stock > 0 && quantity == 0) {
                quantity = 1;
              }
              final double discountedPrice = calculateDiscountedPrice(
                price: product.price,
                discountPercentage: product.discountPercentage,
              );

              final double totalPrice = discountedPrice * quantity;
              return SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: TopBar(
                                isFavorite: isFavorite,
                                onPressed: () => setState(() {
                                      isFavorite = !isFavorite;
                                    })),
                          ),
                          SliverToBoxAdapter(
                            child:
                                ProductImage(imageUrl: product.coverPictureUrl),
                          ),
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20.h),
                                  CategoriesBadge(
                                      categories: product.categories),
                                  SizedBox(height: 10.h),
                                  Text(
                                    product.name,
                                    style: TextStyle(
                                      color: AppColors.textPrimaryColor,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w700,
                                      height: 1.2,
                                    ),
                                  ),
                                  Rating(
                                    rating: product.rating,
                                    reviewsCount: product.reviewsCount,
                                    iconSize: 26,
                                    ratingFontSize: 16,
                                    reviewsFontSize: 14,
                                  ),
                                  SizedBox(height: 16.h),
                                  Price(
                                    price: product.price,
                                    discountPercentage:
                                        product.discountPercentage,
                                  ),
                                  SizedBox(height: 20.h),
                                  ProductInfo(product: product),
                                  SizedBox(height: 24.h),
                                  _buildDescription(product.description),
                                  SizedBox(height: 24.h),
                                  Quantity(
                                    stock: product.stock,
                                    quantity: quantity,
                                    onIncrement: () {
                                      setState(() {
                                        quantity++;
                                      });
                                    },
                                    onDecrement: () {
                                      setState(() {
                                        quantity--;
                                      });
                                    },
                                  ),
                                  SizedBox(height: 24.h),
                                  if (product.stock > 0)
                                    _buildStockText(product.stock),
                                  SizedBox(height: 30.h),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ProductBottomBar(
                      totalPrice: totalPrice,
                      stock: product.stock,
                      onAddToCart: () {},
                    ),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildDescription(String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: TextStyle(
            color: AppColors.textPrimaryColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          description,
          style: TextStyle(
            color: AppColors.textSecondaryColor,
            fontSize: 14.sp,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildStockText(int stock) {
    return Row(
      children: [
        Icon(
          Icons.check_circle_rounded,
          color: Colors.green,
          size: 17.sp,
        ),
        SizedBox(width: 6.w),
        Text(
          '$stock items available',
          style: TextStyle(
            color: AppColors.textSecondaryColor,
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
