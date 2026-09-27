abstract class ProductsEvent {}

class GetAllProductsEvent extends ProductsEvent {
  final int page;

  GetAllProductsEvent({this.page = 1});
}

// class LoadNextProductsPageEvent extends ProductsEvent {}
