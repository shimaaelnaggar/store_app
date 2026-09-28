abstract class ProductsEvent {}

class GetAllProductsEvent extends ProductsEvent {
  final int page;
  final String? searchQuery;

  GetAllProductsEvent({this.page = 1, this.searchQuery});
}
class SearchProductsEvent extends ProductsEvent {
  final String searchQuery;

  SearchProductsEvent({required this.searchQuery});
}


// class LoadNextProductsPageEvent extends ProductsEvent {}
