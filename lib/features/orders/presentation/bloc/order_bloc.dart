import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_orders_usecase.dart';
import '../../domain/usecases/place_order_usecase.dart';
import 'order_event.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final PlaceOrderUseCase placeOrderUseCase;
  final GetOrdersUseCase getOrdersUseCase;

  OrderBloc({required this.placeOrderUseCase, required this.getOrdersUseCase})
      : super(OrderInitialState()) {
    on<PlaceOrderEvent>((
      event,
      emit,
    ) async {
      emit(OrderLoadingState());
      final result = await placeOrderUseCase.execute(
        shippingAddressId: event.shippingAddressId,
      );
      result.fold(
        (failure) =>
            emit(OrderFailureState(errorMessage: failure.errorMessage)),
        (response) => emit(OrderSuccessState(response: response)),
      );
    });

    on<GetOrdersEvent>((event, emit) async {
      emit(GetOrdersLoadingState());

      final result = await getOrdersUseCase.execute();

      result.fold(
        (failure) => emit(
          GetOrdersFailureState(errorMessage: failure.errorMessage),
        ),
        (orders) => emit(
          GetOrdersSuccessState(orders: orders),
        ),
      );
    });
  }
}
