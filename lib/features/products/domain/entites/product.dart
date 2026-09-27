import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String productCode;
  final String name;
  final String description;
  final String arabicName;
  final String arabicDescription;
  final String color;
  final String coverPictureUrl;
  final List<String> categories;
  final int discountPercentage;
  final double price;
  final List<String>? productPictures;
  final double rating;
  final int reviewsCount;
  final String sellerId;
  final int stock;
  final double weight;

  const Product({
    required this.id,
    required this.productCode,
    required this.name,
    required this.description,
    required this.arabicName,
    required this.arabicDescription,
    required this.color,
    required this.coverPictureUrl,
    required this.categories,
    required this.discountPercentage,
    required this.price,
    required this.productPictures,
    required this.rating,
    required this.reviewsCount,
    required this.sellerId,
    required this.stock,
    required this.weight,
  });

  @override
  List<Object?> get props => [
    id,
    productCode,
    name,
    description,
    arabicName,
    arabicDescription,
    color,
    coverPictureUrl,
    categories,
    discountPercentage,
    price,
    productPictures,
    rating,
    reviewsCount,
    sellerId,
    stock,
    weight,
  ];
}