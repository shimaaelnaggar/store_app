import '../../domain/entites/checkout_response.dart';
import '../../domain/entites/order.dart';

abstract class OrderState {}

class OrderInitialState extends OrderState {}

class OrderLoadingState extends OrderState {}

class OrderSuccessState extends OrderState {
  final CheckOutResponse response;

  OrderSuccessState({required this.response});
}

class OrderFailureState extends OrderState {
  final String errorMessage;

  OrderFailureState({required this.errorMessage});
}

class GetOrdersLoadingState extends OrderState {}

class GetOrdersSuccessState extends OrderState {
  final List<OrderEntity> orders;

  GetOrdersSuccessState({required this.orders});
}

class GetOrdersFailureState extends OrderState {
  final String errorMessage;

  GetOrdersFailureState({required this.errorMessage});
}
