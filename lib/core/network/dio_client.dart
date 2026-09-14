import 'package:dio/dio.dart';

class DioClient {
  final Dio dio = Dio(BaseOptions(baseUrl: "https://fakestoreapi.com/"));
}
