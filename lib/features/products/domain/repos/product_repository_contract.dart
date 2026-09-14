import 'package:store/features/products/domain/entites/product.dart';

abstract class ProductRepositoryContract {
  Future<List<Product>> getAllProducts();
  Future<Product> getSingleProduct(int id);
  Future<Product> addNewProduct(Product product);
  Future<Product> updateProduct(Product product);
  Future<void> deleteProduct(int id);
}
