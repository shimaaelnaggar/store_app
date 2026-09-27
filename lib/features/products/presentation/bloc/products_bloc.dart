// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/features/products/domain/usecases/get_all_products_usecase.dart';
import 'package:store/features/products/presentation/bloc/products_event.dart';
import 'package:store/features/products/presentation/bloc/products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetAllProductsUseCase getAllProductsUseCase;
  final int pageSize = 10;
  ProductsBloc({
    required this.getAllProductsUseCase,
  }) : super(ProductsInitialState()) {
    on<GetAllProductsEvent>((event, emit) async {
      emit(ProductsLoadingState());
      final result = await getAllProductsUseCase.execute(
          pageSize: pageSize, page: event.page);
      result.fold(
          (failure) =>
              emit(ProductsFailureState(errorMessage: failure.errorMessage)),
          (productsResult) => emit(ProductsSuccessState(
                products: productsResult.products,
                page: productsResult.page,
                hasNextPage: productsResult.hasNextPage,
                hasPreviousPage: productsResult.hasPreviousPage,
                totalCount: productsResult.totalCount,
              )));
    });
    // on<LoadNextProductsPageEvent>((event, emit) async {
    //   final currentState = state;
    //   if (currentState is! ProductsSuccessState ||
    //       !currentState.hasNextPage ||
    //       currentState.isLoadingMore) {
    //     return;
    //   }
    //   final nextPage = currentState.page + 1;
    //   emit(
    //     ProductsSuccessState(
    //       products: currentState.products,
    //       page: currentState.page,
    //       hasNextPage: currentState.hasNextPage,
    //       isLoadingMore: true,
    //     ),
    //   );
    //   final result = await getAllProductsUseCase.execute(
    //       page: nextPage, pageSize: pageSize);
    //
    //   result.fold(
    //       (failure) => emit(
    //             ProductsSuccessState(
    //               products: currentState.products,
    //               page: currentState.page,
    //               hasNextPage: currentState.hasNextPage,
    //               isLoadingMore: false,
    //             ),
    //           ),
    //       (productsResult) => emit(ProductsSuccessState(
    //               products: [
    //                 ...currentState.products,
    //                 ...productsResult.products,
    //               ],
    //               page: productsResult.page,
    //               hasNextPage: productsResult.hasNextPage,
    //               isLoadingMore: false)));
    // });
  }
}
