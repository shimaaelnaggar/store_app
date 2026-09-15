// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/features/products/domain/usecases/get_all_products_usecase.dart';
import 'package:store/features/products/presentation/bloc/products_event.dart';
import 'package:store/features/products/presentation/bloc/products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetAllProductsUseCase getAllProductsUseCase;
  ProductsBloc({
    required this.getAllProductsUseCase,
  }) : super(ProductsInitialState()) {
    on<GetAllProductsEvent>((event, emit) async {
      emit(ProductsLoadingState());
      final result = await getAllProductsUseCase.execute();
      result.fold(
          (failure) =>
              emit(ProductsFailureState(errorMessage: failure.errorMessage)),
          (products) => emit(ProductsSuccessState(products: products)));
    });
  }
}
