import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'api_endpoints.dart';

/// Singleton HTTP client using Dio. Handles JWT injection and token refresh.
class ApiClient {
  static ApiClient? _instance;
  late final Dio dio;

  ApiClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true),
      );
    }

    dio.interceptors.add(_AuthInterceptor());
  }

  static ApiClient get instance {
    _instance ??= ApiClient._internal();
    return _instance!;
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParams,
  }) => dio.get<T>(path, queryParameters: queryParams);

  Future<Response<T>> post<T>(String path, {dynamic data}) =>
      dio.post<T>(path, data: data);

  Future<Response<T>> put<T>(String path, {dynamic data}) =>
      dio.put<T>(path, data: data);

  Future<Response<T>> delete<T>(String path) => dio.delete<T>(path);
}

/// Interceptor that injects the Bearer token on every request and handles
/// automatic token refresh on 401 responses.
class _AuthInterceptor extends Interceptor {
  final _storage = const FlutterSecureStorage();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _storage.read(key: 'access_token');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      try {
        final refreshToken = await _storage.read(key: 'refresh_token');
        if (refreshToken != null) {
          // Use a fresh Dio instance to avoid interceptor loops
          final refreshDio = Dio(
            BaseOptions(baseUrl: ApiEndpoints.baseUrl),
          );
          final response = await refreshDio.post(
            ApiEndpoints.refresh,
            data: {'refreshToken': refreshToken},
          );

          if (response.data['success'] == true) {
            final newAccessToken =
                response.data['data']['accessToken'] as String;
            final newRefreshToken =
                response.data['data']['refreshToken'] as String;

            await _storage.write(key: 'access_token', value: newAccessToken);
            await _storage.write(
              key: 'refresh_token',
              value: newRefreshToken,
            );

            // Retry the original request with the new token
            err.requestOptions.headers['Authorization'] =
                'Bearer $newAccessToken';
            final retryResponse = await ApiClient.instance.dio.fetch(
              err.requestOptions,
            );
            return handler.resolve(retryResponse);
          }
        }
      } catch (_) {
        // Refresh failed — caller should handle redirect to login
      }
    }
    handler.next(err);
  }
}
