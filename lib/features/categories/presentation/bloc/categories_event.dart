import '../../domain/entities/category.dart';

class CategoriesEvent {}

class GetCategoriesEvent extends CategoriesEvent {}

class SelectCategoryEvent extends CategoriesEvent {
  final Category category;

  SelectCategoryEvent({
    required this.category,
  });
}
