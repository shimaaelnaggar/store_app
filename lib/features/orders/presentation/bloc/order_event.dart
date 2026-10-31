abstract class OrderEvent {}

class PlaceOrderEvent extends OrderEvent {
  final String shippingAddressId;
  final String? couponCode;

  PlaceOrderEvent({
    required this.shippingAddressId,
    this.couponCode,
  });
}

class GetOrdersEvent extends OrderEvent {}
