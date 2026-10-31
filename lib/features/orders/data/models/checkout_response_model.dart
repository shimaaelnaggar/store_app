import 'package:store/features/orders/domain/entites/checkout_response.dart';

class CheckOutResponseModel extends CheckOutResponse {
  const CheckOutResponseModel(
      {required String message,
      required String unifiedCheckoutUrl,
      required String paymentClientSecret})
      : super(
            message: message,
            unifiedCheckoutUrl: unifiedCheckoutUrl,
            paymentClientSecret: paymentClientSecret);

  factory CheckOutResponseModel.fromJson(Map<String, dynamic> json) =>
      CheckOutResponseModel(
        message: json['message'] as String,
        unifiedCheckoutUrl: json['unifiedCheckoutUrl'] as String,
        paymentClientSecret: json['paymentClientSecret'] as String,
      );
}
