import '../../domain/entities/category.dart';

abstract class CategoriesState {}

class CategoriesInitialState extends CategoriesState {}

class CategoriesLoadingState extends CategoriesState {}

class CategoriesSuccessState extends CategoriesState {
  final List<Category> categories;
  final Category? selectedCategory;
  CategoriesSuccessState({required this.categories, this.selectedCategory});
}

class CategoriesErrorState extends CategoriesState {
  final String errorMessage;
  CategoriesErrorState(this.errorMessage);
}
