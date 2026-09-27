import 'package:equatable/equatable.dart';
import 'package:store/features/products/domain/entites/product.dart';

class ProductsResult extends Equatable {
  final List<Product> products;
  final int page;
  final int pageSize;
  final int totalCount;
  final bool hasNextPage;
  final bool hasPreviousPage;

  const ProductsResult({
    required this.products,
    required this.page,
    required this.pageSize,
    required this.totalCount,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  @override
  List<Object?> get props => [
    products,
    page,
    pageSize,
    totalCount,
    hasNextPage,
    hasPreviousPage,
  ];
}