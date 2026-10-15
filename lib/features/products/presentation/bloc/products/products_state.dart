// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:store/features/products/domain/entites/product.dart';

abstract class ProductsState {}

class ProductsInitialState extends ProductsState {}

class ProductsLoadingState extends ProductsState {}

class ProductsSuccessState extends ProductsState {
  final List<Product> products;
  final int page;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final int totalCount;
  final String? searchQuery;
  final String? category;
  ProductsSuccessState({
    required this.products,
    required this.page,
    required this.hasNextPage,
    required this.hasPreviousPage,
    required this.totalCount,
    this.searchQuery,
    this.category,
  });
}

class ProductsFailureState extends ProductsState {
  final String errorMessage;

  ProductsFailureState({required this.errorMessage});
}
