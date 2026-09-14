import 'package:equatable/equatable.dart';
import 'package:store/features/products/domain/entites/rating.dart';

class Product extends Equatable {
  final int id;
  final String title;
  final double price;
  final String desc;
  final String category;
  final String image;
  final Rating rating;

  const Product(
      {required this.price,
      required this.category,
      required this.desc,
      required this.id,
      required this.image,
      required this.rating,
      required this.title});

  @override
  List<Object?> get props => [title, rating, id, desc, price, image, category];
}
