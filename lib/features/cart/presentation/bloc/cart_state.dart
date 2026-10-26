import 'package:store/features/cart/domain/entites/add_to_cart_response.dart';
import '../../domain/entites/cart.dart';

abstract class CartState {}

class CartInitialState extends CartState {}

class AddToCartLoadingState extends CartState {}

class AddToCartSuccessState extends CartState {
  final AddToCartResponse response;

  AddToCartSuccessState({required this.response});
}

class AddToCartFailureState extends CartState {
  final String errorMessage;

  AddToCartFailureState({required this.errorMessage});
}

class GetCartLoadingState extends CartState {}

class GetCartSuccessState extends CartState {
  final Cart cartResponse;
  final String? updatingItemId;

  GetCartSuccessState({
    required this.cartResponse,
    this.updatingItemId,
  });
}

class GetCartFailureState extends CartState {
  final String errorMessage;

  GetCartFailureState({required this.errorMessage});
}
