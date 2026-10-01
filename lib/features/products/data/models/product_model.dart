
import 'package:store/features/products/domain/entites/product.dart';

class ProductModel {
  final String id;
  final String productCode ;
  final String name;
  final String description;
  final String arabicName;
  final String arabicDescription;
  final String color ;
  final String coverPictureUrl;
  final List<String> categories ;
  final int discountPercentage  ;
  final double price ;
  final List<String>? productPictures ;
  final double rating ;
  final int reviewsCount ;
  final String sellerId ;
  final int stock ;
  final double weight;

  ProductModel({required this.id,
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
    required this.weight});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      productCode: json['productCode'],
      name: json['name'],
      description: json['description'],
      arabicName: json['arabicName'] ?? json['nameArabic'],
      arabicDescription:
      json['arabicDescription'] ?? json['descriptionArabic'],
      color: json['color'],
      coverPictureUrl: json['coverPictureUrl'],
      categories: List<String>.from(json['categories'] ?? []),
      discountPercentage: json['discountPercentage'],
      price: (json['price'] as num).toDouble(),
      productPictures: json['productPictures'] != null
          ? List<String>.from(json['productPictures'])
          : null,
      rating: (json['rating'] as num).toDouble(),
      reviewsCount: json['reviewsCount'],
      sellerId: json['sellerId'],
      stock: json['stock'],
      weight: (json['weight'] as num).toDouble(),
    );
  }

  Product toEntity() => Product(
        id: id,
        productCode: productCode,
        name: name,
        description: description,
        arabicName: arabicName,
        arabicDescription: arabicDescription,
        color: color,
        coverPictureUrl: coverPictureUrl,
        categories: categories,
        discountPercentage: discountPercentage,
        price: price,
        productPictures: productPictures,
        rating: rating,
        reviewsCount: reviewsCount,
        sellerId: sellerId,
        stock: stock,
        weight: weight,
      );
}

