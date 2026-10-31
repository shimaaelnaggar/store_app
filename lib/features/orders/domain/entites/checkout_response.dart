import 'package:equatable/equatable.dart';

class CheckOutResponse extends Equatable {
  final String message;
  final String unifiedCheckoutUrl;
  final String paymentClientSecret;

  const CheckOutResponse(
      {required this.message,
      required this.unifiedCheckoutUrl,
      required this.paymentClientSecret});

  @override
  List<Object?> get props => [message, unifiedCheckoutUrl, paymentClientSecret];
}
