import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:store/core/network/dio_client.dart';
import 'package:store/features/products/data/data_sources/products_remote_data_source.dart';
import 'package:store/features/products/data/repos/products_repository_implementation.dart';
import 'package:store/features/products/domain/repos/product_repository_contract.dart';
import 'package:store/features/products/domain/usecases/get_all_products_usecase.dart';
import 'package:store/features/products/presentation/bloc/products_bloc.dart';

final getIt = GetIt.instance;

void setupAppServiceLocator() {
  getIt.registerLazySingleton<Dio>(() => DioClient.createDio());
  getIt.registerLazySingleton<BaseProductsRemoteDataSource>(
      () => ProductsRemoteDataSource(dio: getIt<Dio>()));
  getIt.registerLazySingleton<ProductRepositoryContract>(() =>
      ProductsRepositoryImplementation(
          dataSource: getIt<BaseProductsRemoteDataSource>()));
  getIt.registerLazySingleton<GetAllProductsUseCase>(() =>
      GetAllProductsUseCase(repository: getIt<ProductRepositoryContract>()));
  getIt.registerFactory<ProductsBloc>(() =>
      ProductsBloc(getAllProductsUseCase: getIt<GetAllProductsUseCase>()));
}
