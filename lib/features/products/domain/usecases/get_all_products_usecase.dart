import 'package:store/features/products/domain/entites/product.dart';
import 'package:store/features/products/domain/repos/product_repository_contract.dart';

class GetAllProductsUseCase {
  final ProductRepositoryContract repository;

  GetAllProductsUseCase({required this.repository}); //dependency injection

  Future<List<Product>> execute() {
    return repository.getAllProducts();
  }
}
