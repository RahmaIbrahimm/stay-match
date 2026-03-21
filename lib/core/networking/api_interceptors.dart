import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:stay_match/core/utils/secure_storage_helper.dart';

class ApiInterceptors extends Interceptor {
  final Dio dio;
  bool _isRefreshing = false;
  final List<(_CompleteCallback, ErrorCallback)> _pendingRequests = [];

  ApiInterceptors(this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await SecureStorageHelper.readFromSecureStorage(key: SecureStorageHelper.tokenKey);

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Token expired, try to refresh
      await _refreshToken(err, handler);
    } else {
      handler.next(err);
    }
  }
// fixme : add force logout
  Future<void> _refreshToken(DioException originalError, ErrorInterceptorHandler handler) async {
    // If already refreshing, add to queue
    if (_isRefreshing) {
      _pendingRequests.add((handler, originalError));
      return;
    }

    _isRefreshing = true;

    try {
      final refreshToken = await SecureStorageHelper.readFromSecureStorage(key: SecureStorageHelper.refreshTokenKey);

      if (refreshToken == null) {
        // No refresh token, force logout
        // _forceLogout();
        handler.reject(originalError);
        return;
      }

      // Call refresh token API
      final response = await dio.post(
        '/api/auth/refresh-token',
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200) {
        final newToken = response.data['token'];
        final newRefreshToken = response.data['refreshToken'];

        // Save new tokens
        await SecureStorageHelper.addToSecureStorage(key: SecureStorageHelper.tokenKey,value: newToken);
        await SecureStorageHelper.addToSecureStorage(key: SecureStorageHelper.tokenKey,value: newRefreshToken);

        // Retry all pending requests with new token
        for (final pending in _pendingRequests) {
          final (callback, error) = pending;
          _retryRequest(error.requestOptions, callback);
        }
        _pendingRequests.clear();

        // Retry the original request
        _retryRequest(originalError.requestOptions, handler);
      } else {
        // Refresh failed, force logout
        // _forceLogout();
        handler.reject(originalError);
      }
    } catch (e) {
      // _forceLogout();
      handler.reject(originalError);
    } finally {
      _isRefreshing = false;
    }
  }

  Future<void> _retryRequest(RequestOptions requestOptions, ErrorInterceptorHandler handler) async {
    final newToken = await SecureStorageHelper.readFromSecureStorage(key: SecureStorageHelper.tokenKey);

    if (newToken != null) {
      requestOptions.headers['Authorization'] = 'Bearer $newToken';
    }

    try {
      final response = await dio.fetch(requestOptions);
      handler.resolve(response);
    } catch (e) {
      handler.reject(e as DioException);
    }
  }

  // void _forceLogout() {
  //   // Clear tokens
  //   SecureStorageHelper.clearAll();
  //
  //   // Navigate to login (using a global navigator key or callback)
  //   // You can use a GlobalKey<NavigatorState> for this
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     // Navigate to login screen
  //     // navigatorKey.currentState?.pushNamedAndRemoveUntil('/login', (route) => false);
  //   });
  // }
}

typedef _CompleteCallback = ErrorInterceptorHandler;
typedef ErrorCallback = DioException;