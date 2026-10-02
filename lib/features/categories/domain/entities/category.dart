import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String name;
  final String id;
  const Category({
    required this.name,
    required this.id,
  });
  @override
  List<Object?> get props => [name, id];
}
