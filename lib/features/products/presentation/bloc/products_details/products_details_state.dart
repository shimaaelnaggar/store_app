import '../../../domain/entites/product.dart';

abstract class ProductsDetailsStates {}

class ProductsDetailsInitialState extends ProductsDetailsStates {}

class ProductsDetailsLoading extends ProductsDetailsStates {}

class ProductsDetailsSuccess extends ProductsDetailsStates {
  final Product product;
  ProductsDetailsSuccess({required this.product});
}

class ProductsDetailsFailure extends ProductsDetailsStates {
  final String errorMessage;
  ProductsDetailsFailure({required this.errorMessage});
}
