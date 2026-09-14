import 'package:equatable/equatable.dart';

class Rating extends Equatable {
  final double rate;
  final int count;

  const Rating({required this.count, required this.rate});
  @override
  List<Object?> get props => [rate, count];
}
