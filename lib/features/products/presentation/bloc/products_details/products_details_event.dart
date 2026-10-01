class ProductsDetailsEvent {}

class GetSingleProductEvent extends ProductsDetailsEvent {
  final String id;
  GetSingleProductEvent({required this.id});
}
