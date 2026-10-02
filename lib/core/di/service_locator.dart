import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:store/core/network/dio_client.dart';
import 'package:store/features/categories/domain/Repos/categories_repository_contract.dart';
import 'package:store/features/categories/domain/useCases/get_categories_usecase.dart';
import 'package:store/features/products/data/data_sources/products_remote_data_source.dart';
import 'package:store/features/products/data/repos/products_repository_implementation.dart';
import 'package:store/features/products/domain/repos/product_repository_contract.dart';
import 'package:store/features/products/domain/usecases/get_all_products_usecase.dart';
import 'package:store/features/products/presentation/bloc/products/products_bloc.dart';
import '../../features/categories/data/data_sources/categories_remote_data_source.dart';
import '../../features/categories/data/repos/categories_repository_impl.dart';
import '../../features/categories/presentation/bloc/categories_bloc.dart';
import '../../features/products/domain/usecases/get_single_product_usecase.dart';
import '../../features/products/presentation/bloc/products_details/products_details_bloc.dart';
import '../routing/app_router.dart';

final getIt = GetIt.instance;

void setupAppServiceLocator() {
  getIt.registerLazySingleton<Dio>(
    () => DioClient.createDio(),
  );

  getIt.registerLazySingleton<BaseProductsRemoteDataSource>(
    () => ProductsRemoteDataSource(
      dio: getIt<Dio>(),
    ),
  );

  getIt.registerLazySingleton<ProductRepositoryContract>(
    () => ProductsRepositoryImplementation(
      dataSource: getIt<BaseProductsRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<GetAllProductsUseCase>(
    () => GetAllProductsUseCase(
      repository: getIt<ProductRepositoryContract>(),
    ),
  );

  getIt.registerFactory<ProductsBloc>(
    () => ProductsBloc(
      getAllProductsUseCase: getIt<GetAllProductsUseCase>(),
    ),
  );

  getIt.registerLazySingleton<GetSingleProductUseCase>(
    () => GetSingleProductUseCase(
      repository: getIt<ProductRepositoryContract>(),
    ),
  );

  getIt.registerFactory<ProductsDetailsBloc>(
    () => ProductsDetailsBloc(
      getSingleProductUseCase: getIt<GetSingleProductUseCase>(),
    ),
  );

  getIt.registerLazySingleton<BaseCategoriesRemoteDataSource>(
    () => CategoriesRemoteDataSource(
      dio: getIt<Dio>(),
    ),
  );

  getIt.registerLazySingleton<CategoriesRepositoryContract>(
    () => CategoriesRepositoryImpl(
      remoteDataSource: getIt<BaseCategoriesRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<GetCategoriesUseCase>(
    () => GetCategoriesUseCase(
      repository: getIt<CategoriesRepositoryContract>(),
    ),
  );

  getIt.registerFactory<CategoriesBloc>(
    () => CategoriesBloc(
      getCategoriesUseCase: getIt<GetCategoriesUseCase>(),
    ),
  );

  getIt.registerLazySingleton<AppRouter>(
    () => AppRouter(),
  );
}
