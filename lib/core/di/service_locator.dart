import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:store/core/network/dio_client.dart';
import 'package:store/features/auth/data/data_sources/login_remote_datasource.dart';
import 'package:store/features/auth/data/data_sources/verify_email_remote_datasource.dart';
import 'package:store/features/auth/data/repos/login_repository_impl.dart';
import 'package:store/features/auth/domain/repos/login_repository_contract.dart';
import 'package:store/features/auth/domain/repos/register_repository_contract.dart';
import 'package:store/features/auth/domain/usecases/create_account_usecase.dart';
import 'package:store/features/auth/domain/usecases/login_use_case.dart';
import 'package:store/features/auth/domain/usecases/verify_email_usecase.dart';
import 'package:store/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:store/features/categories/domain/Repos/categories_repository_contract.dart';
import 'package:store/features/categories/domain/useCases/get_categories_usecase.dart';
import 'package:store/features/products/data/data_sources/products_remote_data_source.dart';
import 'package:store/features/products/data/repos/products_repository_implementation.dart';
import 'package:store/features/products/domain/repos/product_repository_contract.dart';
import 'package:store/features/products/domain/usecases/get_all_products_usecase.dart';
import 'package:store/features/products/presentation/bloc/products/products_bloc.dart';
import '../../features/auth/data/data_sources/register_remote_dataSource.dart';
import '../../features/auth/data/data_sources/resend_otp_remote_datasource.dart';
import '../../features/auth/data/repos/register_repository_impl.dart';
import '../../features/auth/data/repos/resend_otp_repository_impl.dart';
import '../../features/auth/data/repos/verify_email_repository_impl.dart';
import '../../features/auth/domain/repos/resend_otp_repository_contract.dart';
import '../../features/auth/domain/repos/verify_email_repository_contract.dart';
import '../../features/auth/domain/usecases/resend_otp_usecase.dart';
import '../../features/auth/presentation/bloc/register/register_bloc.dart';
import '../../features/auth/presentation/bloc/verify_email/verify_email_bloc.dart';
import '../../features/categories/data/data_sources/categories_remote_data_source.dart';
import '../../features/categories/data/repos/categories_repository_impl.dart';
import '../../features/categories/presentation/bloc/categories_bloc.dart';
import '../../features/products/domain/usecases/get_single_product_usecase.dart';
import '../../features/products/presentation/bloc/products_details/products_details_bloc.dart';
import '../routing/app_router.dart';
import '../storage/auth_storage.dart';

final getIt = GetIt.instance;

void setupAppServiceLocator() {
  getIt.registerLazySingleton<Dio>(
    () => DioClient.createDio(),
  );

//products
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

//categories
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

//register
  getIt.registerLazySingleton<BaseRegisterRemoteDataSource>(
      () => RegisterRemoteDataSource(
            dio: getIt<Dio>(),
          ));

  getIt.registerLazySingleton<RegisterRepositoryContract>(
      () => RegisterRepositoryImpl(
            dateSource: getIt<BaseRegisterRemoteDataSource>(),
          ));

  getIt.registerLazySingleton<CreateAccountUseCase>(() =>
      CreateAccountUseCase(repository: getIt<RegisterRepositoryContract>()));

  getIt.registerFactory<RegisterBloc>(
      () => RegisterBloc(createAccountUseCase: getIt<CreateAccountUseCase>()));

//verify_email
  getIt.registerLazySingleton<BaseVerifyEmailRemoteDateSource>(
      () => VerifyEmailRemoteDataSource(
            dio: getIt<Dio>(),
          ));

  getIt.registerLazySingleton<VerifyEmailRepositoryContract>(
      () => VerifyEmailRepositoryImpl(
            dateSource: getIt<BaseVerifyEmailRemoteDateSource>(),
          ));

  getIt.registerLazySingleton<VerifyEmailUseCase>(() =>
      VerifyEmailUseCase(repository: getIt<VerifyEmailRepositoryContract>()));

  getIt.registerFactory<VerifyEmailBloc>(() => VerifyEmailBloc(
        verifyEmailUseCase: getIt<VerifyEmailUseCase>(),
        resendOtpUseCase: getIt<ResendOtpUseCase>(),
      ));

  getIt.registerLazySingleton<ResendOtpUseCase>(() => ResendOtpUseCase(
        repository: getIt<ResendOtpRepositoryContract>(),
      ));

  getIt.registerLazySingleton<ResendOtpRepositoryContract>(
      () => ResendOtpRepositoryImpl(
            remoteDataSource: getIt<BaseResendOtpRemoteDataSource>(),
          ));

  getIt.registerLazySingleton<BaseResendOtpRemoteDataSource>(
      () => ResendOtpRemoteDataSource(
            dio: getIt<Dio>(),
          ));

  //storage
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  getIt.registerLazySingleton<AuthStorage>(
    () => AuthStorage(
      storage: getIt<FlutterSecureStorage>(),
    ),
  );

// Login
  getIt.registerLazySingleton<BaseLoginRemoteDataSource>(
    () => LoginRemoteDataSource(
      dio: getIt<Dio>(),
    ),
  );

  getIt.registerLazySingleton<LoginRepositoryContract>(
    () => LoginRepositoryImpl(
      dataSource: getIt<BaseLoginRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      repository: getIt<LoginRepositoryContract>(),
    ),
  );

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      loginUseCase: getIt<LoginUseCase>(),
      authStorage: getIt<AuthStorage>(),
    ),
  );

//routing
  getIt.registerLazySingleton<AppRouter>(
    () => AppRouter(),
  );
}
