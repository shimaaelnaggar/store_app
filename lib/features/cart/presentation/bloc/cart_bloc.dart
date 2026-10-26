import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/features/cart/presentation/bloc/cart_event.dart';
import 'package:store/features/cart/presentation/bloc/cart_state.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entites/cart.dart';
import '../../domain/usecases/add_to_cart_usecase.dart';
import '../../domain/usecases/decrement_quantity_usecase.dart';
import '../../domain/usecases/get_cart_usecase.dart';
import '../../domain/usecases/remove_cart_item_usecase.dart';
import '../../domain/usecases/update_quantity_usecase.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddToCartUseCase addToCartUseCase;
  final GetCartUseCase getCartUseCase;
  final UpdateQuantityUseCase updateQuantityUseCase;
  final DecrementQuantityUseCase decrementQuantityUseCase;
  final RemoveCartItemUseCase removeCartItemUseCase;

  Cart? currentCart;

  CartBloc({
    required this.addToCartUseCase,
    required this.getCartUseCase,
    required this.updateQuantityUseCase,
    required this.decrementQuantityUseCase,
    required this.removeCartItemUseCase,
  }) : super(CartInitialState()) {
    on<AddToCartEvent>((event, emit) async {
      emit(AddToCartLoadingState());

      final response = await addToCartUseCase.execute(
        productId: event.productId,
        quantity: event.quantity,
      );

      response.fold(
        (failure) {
          emit(AddToCartFailureState(
            errorMessage: failure.errorMessage,
          ));
        },
        (response) {
          emit(AddToCartSuccessState(response: response));
        },
      );
    });

    on<GetCartEvent>((event, emit) async {
      if (currentCart == null) {
        emit(GetCartLoadingState());
      }

      final response = await getCartUseCase.execute();

      response.fold(
        (failure) {
          if (currentCart == null) {
            emit(GetCartFailureState(
              errorMessage: failure.errorMessage,
            ));
          } else {
            emit(GetCartSuccessState(
              cartResponse: currentCart!,
            ));
          }
        },
        (cart) {
          currentCart = cart;
          emit(GetCartSuccessState(
            cartResponse: cart,
          ));
        },
      );
    });

    on<UpdateCartItemQuantityEvent>((event, emit) async {
      await _performCartOperation(
        itemId: event.itemId,
        emit: emit,
        operation: () => updateQuantityUseCase.execute(
          itemId: event.itemId,
          quantity: event.quantity,
        ),
      );
    });

    on<DecrementCartItemQuantityEvent>((event, emit) async {
      await _performCartOperation(
        itemId: event.itemId,
        emit: emit,
        operation: () => decrementQuantityUseCase.execute(
          itemId: event.itemId,
          quantity: event.quantity,
        ),
      );
    });

    on<RemoveCartItemEvent>((event, emit) async {
      await _performCartOperation(
        itemId: event.itemId,
        emit: emit,
        operation: () => removeCartItemUseCase.execute(
          itemId: event.itemId,
        ),
      );
    });
  }

  Future<void> _performCartOperation({
    required String itemId,
    required Emitter<CartState> emit,
    required Future<Either<Failure, Unit>> Function() operation,
  }) async {
    final cart = currentCart;

    if (cart == null) return;

    emit(GetCartSuccessState(
      cartResponse: cart,
      updatingItemId: itemId,
    ));

    final result = await operation();

    result.fold(
      (failure) {
        emit(GetCartSuccessState(
          cartResponse: cart,
        ));
      },
      (_) {
        add(GetCartEvent());
      },
    );
  }
}
