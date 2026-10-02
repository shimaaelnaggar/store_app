import '../../domain/entities/category.dart';

class CategoryModel {
  final String name;
  final String coverPictureUrl;
  final String id;
  final String description;

  CategoryModel(
      {required this.name,
      required this.coverPictureUrl,
      required this.id,
      required this.description});

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
      name: json['name'],
      coverPictureUrl: json['coverPictureUrl'],
      id: json['id'],
      description: json['description']);

  Category toEntity() => Category(
        name: name,
        id: id,
      );
}
