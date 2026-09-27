import 'package:store/features/products/data/models/product_model.dart';
import 'package:store/features/products/domain/entites/products_result.dart';

class ProductsResponseModel {
  final List<ProductModel> items;
  final int page;
  final int pageSize;
  final int totalCount;
  final bool hasNextPage;
  final bool hasPreviousPage;

  const ProductsResponseModel({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.totalCount,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  factory ProductsResponseModel.fromJson(Map<String, dynamic> json) {
    return ProductsResponseModel(
      items: (json['items'] as List)
          .map((item) => ProductModel.fromJson(item))
          .toList(),
      page: json['page'],
      pageSize: json['pageSize'],
      totalCount: json['totalCount'],
      hasNextPage: json['hasNextPage'],
      hasPreviousPage: json['hasPreviousPage'],
    );
  }

  ProductsResult toEntity()=>ProductsResult(
    products: items.map((e) => e.toEntity()).toList(),
    page: page,
    pageSize: pageSize,
    totalCount: totalCount,
    hasNextPage: hasNextPage,
    hasPreviousPage: hasPreviousPage,

  );
}