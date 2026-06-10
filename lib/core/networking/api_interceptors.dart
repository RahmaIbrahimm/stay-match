
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:stay_match/core/networking/endpoints.dart';
import 'package:stay_match/core/utils/secure_storage_helper.dart';

import '../utils/secure_storage_keys.dart';
import '../utils/service_locator.dart';

class ApiInterceptors extends Interceptor {
  final Dio dio;
  bool _isRefreshing = false;

  // Use a list of completers or a simple list of pending requests to retry
  final List<({RequestOptions options, ErrorInterceptorHandler handler})>
  _pendingRequests = [];
  final secureStorage = getIt.get<SecureStorageHelper>();

  ApiInterceptors(this.dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    log('onRequest', name: 'ApiInterceptors');
    final token = await secureStorage.readFromSecureStorage(
        key: SecureStorageKeys.tokenKey);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    log('onError', name: 'ApiInterceptors');
    if (err.response?.data != null) {
      final errorDetail = const JsonEncoder.withIndent('  ').convert(err.response?.data);
      log("🔴 ERROR SERVER RESPONSE:\n$errorDetail", name: 'DioError');
    }
    // Only attempt refresh on 401 Unauthorized
    if (err.response?.statusCode == 401) {
      if (err.requestOptions.path == Endpoints.refreshToken) {
        await _forceLogout();
        return handler.reject(err);
      }

      // ← ADD THIS: if it's an invalid credentials error, don't refresh
      final data = err.response?.data;
      if (data is Map && data['errors'] != null) {
        final errors = data['errors'] as Map;
        if (errors.containsKey('InvalidCredentials')) {
          return handler.next(err); // pass through as normal error
        }
      }

      log('error not 401 1', name: 'ApiInterceptors');
      await _refreshToken(err, handler);
    } else {
      log('error not 401 2', name: 'ApiInterceptors');
      handler.next(err);
    }
  }

  Future<void> _refreshToken(
    DioException originalError,
    ErrorInterceptorHandler handler,
  ) async {
    // If already refreshing, queue this request
    if (_isRefreshing) {
      _pendingRequests.add((
        options: originalError.requestOptions,
        handler: handler,
      ));
      return;
    }

    _isRefreshing = true;

    try {

      final refreshToken = await secureStorage.readFromSecureStorage(
          key: SecureStorageKeys.refreshTokenKey);
      log('refresh token : $refreshToken', name: 'ApiInterceptors');
      if (refreshToken == null) {
        log('no refresh token', name: 'ApiInterceptors');
        await _forceLogout();
        handler.reject(originalError);
        return;
      }

      // Call refresh token API using a clean Dio instance or directly
      // to avoid triggering the same interceptor logic recursively
      final response = await dio.post(
        Endpoints.refreshToken,
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200) {
        final newToken = response.data['token'];
        final newRefreshToken = response.data['refreshToken'];
        await secureStorage.addToSecureStorage(
            key: SecureStorageKeys.tokenKey,        // ← was missing
            value: newToken);
        await secureStorage.addToSecureStorage(
            key: SecureStorageKeys.refreshTokenKey,
            value: newRefreshToken); // 1. Retry the original request that triggered the refresh
        await _retryRequest(originalError.requestOptions, handler);

        // 2. Retry all other pending requests that were queued
        for (final pending in _pendingRequests) {
          await _retryRequest(pending.options, pending.handler);
        }
        _pendingRequests.clear();
      } else {
        await _forceLogout();
        handler.reject(originalError);
      }
    } catch (e) {
      await _forceLogout();
      handler.reject(originalError);
    } finally {
      _isRefreshing = false;
    }
  }

  Future<void> _retryRequest(
    RequestOptions requestOptions,
    ErrorInterceptorHandler handler,
  ) async {
    final newToken = await secureStorage.readFromSecureStorage(
        key: SecureStorageKeys.tokenKey);
    if (newToken != null) {
      requestOptions.headers['Authorization'] = 'Bearer $newToken';
    }

    try {
      // Use dio.fetch to re-run the request with updated headers
      final response = await dio.fetch(requestOptions);
      handler.resolve(response);
    } catch (e) {
      if (e is DioException) {
        handler.reject(e);
      } else {
        handler.reject(DioException(requestOptions: requestOptions, error: e));
      }
    }
  }

  Future<void> _forceLogout() async {
    _isRefreshing = false;
    _pendingRequests.clear();
    await secureStorage.storage.deleteAll();
  }
}