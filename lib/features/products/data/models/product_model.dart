import 'package:store/features/products/data/models/rating_model.dart';
import 'package:store/features/products/domain/entites/product.dart';

class ProductModel {
  final int id;
  final String title;
  final double price;
  final String desc;
  final String category;
  final String image;
  final RatingModel ratingModel;

  const ProductModel(
      {required this.price,
      required this.category,
      required this.desc,
      required this.id,
      required this.image,
      required this.ratingModel,
      required this.title});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      price:  (json['price'] as num).toDouble(),
      category: json['category'],
      desc: json['description'],
      id: json['id'],
      image: json['image'],
      ratingModel: RatingModel.fromJson(json['rating']),
      title: json['title']);

  Map<String, dynamic> toJson() => {
        'title': title,
        'rating': ratingModel.toJson(),
        'image': image,
        'id': id,
        'description': desc,
        'category': category,
        'price': price
      };

  Product toEntity() => Product(
      price: price,
      category: category,
      desc: desc,
      id: id,
      image: image,
      rating: ratingModel.toEntity(),
      title: title);
}
