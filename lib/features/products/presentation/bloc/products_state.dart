// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:store/features/products/domain/entites/product.dart';

abstract class ProductsState {}

class ProductsInitialState extends ProductsState {}

class ProductsLoadingState extends ProductsState {}

class ProductsSuccessState extends ProductsState {
  final List<Product> products;
  ProductsSuccessState({
    required this.products,
  });
}

class ProductsFailureState extends ProductsState {
  final String errorMessage;

  ProductsFailureState({required this.errorMessage});
}
