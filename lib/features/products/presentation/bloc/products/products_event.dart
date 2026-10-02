abstract class ProductsEvent {}

class GetAllProductsEvent extends ProductsEvent {
  final int page;
  final String? searchQuery;
  final String? category;

  GetAllProductsEvent({this.page = 1, this.searchQuery, this.category});
}

class SearchProductsEvent extends ProductsEvent {
  final String searchQuery;

  SearchProductsEvent({required this.searchQuery});
}

// class LoadNextProductsPageEvent extends ProductsEvent {}
