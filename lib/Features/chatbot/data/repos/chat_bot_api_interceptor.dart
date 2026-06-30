import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:stay_match/core/networking/endpoints.dart';
import 'package:stay_match/core/utils/secure_storage_helper.dart';
import 'package:stay_match/core/utils/secure_storage_keys.dart';
import 'package:stay_match/core/utils/service_locator.dart';

class ChatbotApiInterceptor extends Interceptor {
  final Dio dio;
  final _secureStorage = getIt.get<SecureStorageHelper>();

  ChatbotApiInterceptor(this.dio);

  @override
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _secureStorage.readFromSecureStorage(
        key: SecureStorageKeys.tokenKey);
    log('chatbot token: $token', name: 'ChatbotApiInterceptor'); // add this

    if (token == null) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: 'No auth token found.',
        ),
      );
    }

    options.headers['Authorization'] = 'Bearer $token';
    super.onRequest(options, handler);
  }
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        final refreshToken = await _secureStorage.readFromSecureStorage(
            key: SecureStorageKeys.refreshTokenKey);
        if (refreshToken == null) return handler.reject(err);

        final refreshDio = Dio(BaseOptions(baseUrl: Endpoints.baseUrl));
        final response = await refreshDio.post(
          Endpoints.refreshToken,
          data: {'refreshToken': refreshToken},
        );

        if (response.statusCode == 200) {
          final newToken = response.data['token'];
          final newRefreshToken = response.data['refreshToken'];

          await _secureStorage.addToSecureStorage(
              key: SecureStorageKeys.tokenKey, value: newToken);
          await _secureStorage.addToSecureStorage(
              key: SecureStorageKeys.refreshTokenKey, value: newRefreshToken);

          // Retry with Token prefix
          err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
          final retried = await dio.fetch(err.requestOptions);
          return handler.resolve(retried);
        } else {
          return handler.reject(err);
        }
      } catch (_) {
        return handler.reject(err);
      }
    }
    handler.next(err);
  }
}