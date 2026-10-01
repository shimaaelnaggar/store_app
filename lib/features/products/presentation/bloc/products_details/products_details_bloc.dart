import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/features/products/domain/usecases/get_single_product_usecase.dart';
import 'package:store/features/products/presentation/bloc/products_details/products_details_event.dart';
import 'package:store/features/products/presentation/bloc/products_details/products_details_state.dart';

class ProductsDetailsBloc
    extends Bloc<ProductsDetailsEvent, ProductsDetailsStates> {
  final GetSingleProductUseCase getSingleProductUseCase;

  ProductsDetailsBloc({required this.getSingleProductUseCase})
      : super(ProductsDetailsInitialState()) {
    on<GetSingleProductEvent>((event, emit) async {
      emit(ProductsDetailsLoading());
      final result = await getSingleProductUseCase.execute(id: event.id);
      result.fold(
          (failure) =>
              emit(ProductsDetailsFailure(errorMessage: failure.errorMessage)),
          (product) => emit(ProductsDetailsSuccess(product: product)));
    });
  }
}
