import 'package:dio/dio.dart';

class DioClient {
  static Dio createDio() => Dio(
        BaseOptions(
          baseUrl: "https://fakestoreapi.com/",
          connectTimeout: const Duration(seconds: 2),
          receiveTimeout: const Duration(seconds: 2),
          sendTimeout: const Duration(seconds: 2),
        ),
      );
}
