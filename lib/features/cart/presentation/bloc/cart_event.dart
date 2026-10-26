abstract class CartEvent {}

class AddToCartEvent extends CartEvent {
  final String productId;
  final int quantity;

  AddToCartEvent({required this.productId, required this.quantity});
}

class GetCartEvent extends CartEvent {}

class UpdateCartItemQuantityEvent extends CartEvent {
  final String itemId;
  final int quantity;

  UpdateCartItemQuantityEvent({
    required this.itemId,
    required this.quantity,
  });
}

class DecrementCartItemQuantityEvent extends CartEvent {
  final String itemId;
  final int quantity;

  DecrementCartItemQuantityEvent({
    required this.itemId,
    required this.quantity,
  });
}

class RemoveCartItemEvent extends CartEvent {
  final String itemId;

  RemoveCartItemEvent({required this.itemId});
}
