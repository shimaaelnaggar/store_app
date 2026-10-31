import 'package:dio/dio.dart';

import '../storage/auth_storage.dart';
import 'auth_interceptor.dart';

class DioClient {
  static const baseUrl = 'https://accessories-eshop.runasp.net/';
  static const Duration timeOut = Duration(seconds: 10);
  static Dio createDio(AuthStorage authStorage, Dio refreshDio) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: timeOut,
        receiveTimeout: timeOut,
        sendTimeout: timeOut,
      ),
    );

    dio.interceptors.add(AuthInterceptor(
      authStorage: authStorage,
      refreshDio: refreshDio,
      dio: dio,
    ));

    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: false,
        responseUrl: true,
        responseHeader: false,
        error: true,
      ),
    );

    return dio;
  }

  static Dio createRefreshDio() {
    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: timeOut,
        receiveTimeout: timeOut,
        sendTimeout: timeOut,
      ),
    );
  }

  static Dio createLocationSearchDio(){
    return Dio(
      BaseOptions(
        baseUrl: 'https://nominatim.openstreetmap.org/',
        connectTimeout: timeOut,
        receiveTimeout: timeOut,
        sendTimeout: timeOut,
        headers: {
          'User-Agent': 'store-app',
        },
      ),
    );

  }
}
