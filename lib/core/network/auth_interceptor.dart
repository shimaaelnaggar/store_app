import 'package:dio/dio.dart';

import '../storage/auth_storage.dart';

class AuthInterceptor extends Interceptor {
  final AuthStorage authStorage;
  final Dio refreshDio;
  final Dio dio;

  AuthInterceptor({
    required this.authStorage,
    required this.refreshDio,
    required this.dio,
  });

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final accessToken = await authStorage.getAccessToken();

      if (accessToken != null && accessToken.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }

      handler.next(options);
    } catch (_) {
      handler.next(options);
    }
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    final options = err.requestOptions;

    if (options.extra['retried'] == true) {
      return handler.next(err);
    }

    // Don't refresh tokens for login or registration requests.
    final path = options.uri.path;
    if (path.endsWith('/api/auth/login') ||
        path.endsWith('/api/auth/register') ||
        path.endsWith('/api/auth/refresh-token')) {
      return handler.next(err);
    }

    final refreshToken = await authStorage.getRefreshToken();

    if (refreshToken == null || refreshToken.isEmpty) {
      await authStorage.clearTokens();
      return handler.next(err);
    }

    try {
      final refreshResponse = await refreshDio.post<dynamic>(
        '/api/auth/refresh-token',
        data: {
          'refreshToken': refreshToken,
          'useCookies': false,
        },
      );

      final data = refreshResponse.data as Map<String, dynamic>;

      final newAccessToken = data['accessToken'] as String;
      final newRefreshToken = data['refreshToken'] as String;

      await authStorage.saveTokens(
        accessToken: newAccessToken,
        refreshToken: newRefreshToken,
      );

      options.extra['retried'] = true;
      options.headers['Authorization'] = 'Bearer $newAccessToken';

      try {
        final retryResponse = await dio.fetch<dynamic>(options);
        return handler.resolve(retryResponse);
      } on DioException catch (retryError) {
        return handler.next(retryError);
      }
    } on DioException catch (refreshError) {
      final statusCode = refreshError.response?.statusCode;

      if (statusCode == 400 || statusCode == 401) {
        await authStorage.clearTokens();
      }

      return handler.next(err);
    } catch (_) {
      return handler.next(err);
    }
  }
}
