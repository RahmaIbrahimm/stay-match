// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:stay_match/core/networking/endpoints.dart';
// import 'package:stay_match/core/utils/secure_storage_helper.dart';
//
// class ApiInterceptors extends Interceptor {
//   final Dio dio;
//   bool _isRefreshing = false;
//   final List<(_CompleteCallback, ErrorCallback)> _pendingRequests = [];
//
//   ApiInterceptors(this.dio);
//
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
//     final token = await SecureStorageHelper.readFromSecureStorage(key: SecureStorageHelper.tokenKey);
//
//     if (token != null) {
//       options.headers['Authorization'] = 'Bearer $token';
//     }
//
//     super.onRequest(options, handler);
//   }
//
//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) async {
//     if (err.response?.statusCode == 401) {
//       // Token expired, try to refresh
//       await _refreshToken(err, handler);
//     } else {
//       handler.next(err);
//     }
//   }
// // fixme : add force logout
//   Future<void> _refreshToken(DioException originalError, ErrorInterceptorHandler handler) async {
//     // If already refreshing, add to queue
//     if (_isRefreshing) {
//       _pendingRequests.add((handler, originalError));
//       return;
//     }
//
//     _isRefreshing = true;
//
//     try {
//       final refreshToken = await SecureStorageHelper.readFromSecureStorage(key: SecureStorageHelper.refreshTokenKey);
//
//       if (refreshToken == null) {
//         // No refresh token, force logout
//         // _forceLogout();
//         handler.reject(originalError);
//         return;
//       }
//
//       // Call refresh token API
//       final response = await dio.post(
//         Endpoints.refreshToken,
//         data: {'refreshToken': refreshToken},
//       );
//
//       if (response.statusCode == 200) {
//         final newToken = response.data['token'];
//         final newRefreshToken = response.data['refreshToken'];
//
//         // Save new tokens
//         await SecureStorageHelper.addToSecureStorage(key: SecureStorageHelper.tokenKey,value: newToken);
//         await SecureStorageHelper.addToSecureStorage(key: SecureStorageHelper.refreshTokenKey,value: newRefreshToken);
//
//         // Retry all pending requests with new token
//         for (final pending in _pendingRequests) {
//           final (callback, error) = pending;
//           _retryRequest(error.requestOptions, callback);
//         }
//         _pendingRequests.clear();
//
//         // Retry the original request
//         _retryRequest(originalError.requestOptions, handler);
//       } else {
//         // Refresh failed, force logout
//         // _forceLogout();
//         handler.reject(originalError);
//       }
//     } catch (e) {
//       // _forceLogout();
//       handler.reject(originalError);
//     } finally {
//       _isRefreshing = false;
//     }
//   }
//
//   Future<void> _retryRequest(RequestOptions requestOptions, ErrorInterceptorHandler handler) async {
//     final newToken = await SecureStorageHelper.readFromSecureStorage(key: SecureStorageHelper.tokenKey);
//
//     if (newToken != null) {
//       requestOptions.headers['Authorization'] = 'Bearer $newToken';
//     }
//
//     try {
//       final response = await dio.fetch(requestOptions);
//       handler.resolve(response);
//     } catch (e) {
//       handler.reject(e as DioException);
//     }
//   }
//
//   // void _forceLogout() {
//   //   // Clear tokens
//   //   SecureStorageHelper.clearAll();
//   //
//   //   // Navigate to login (using a global navigator key or callback)
//   //   // You can use a GlobalKey<NavigatorState> for this
//   //   WidgetsBinding.instance.addPostFrameCallback((_) {
//   //     // Navigate to login screen
//   //     // navigatorKey.currentState?.pushNamedAndRemoveUntil('/login', (route) => false);
//   //   });
//   // }
// }
//
// typedef _CompleteCallback = ErrorInterceptorHandler;
// typedef ErrorCallback = DioException;

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:stay_match/core/networking/endpoints.dart';
import 'package:stay_match/core/utils/secure_storage_helper.dart';

class ApiInterceptors extends Interceptor {
  final Dio dio;
  bool _isRefreshing = false;

  // Use a list of completers or a simple list of pending requests to retry
  final List<
      ({RequestOptions options, ErrorInterceptorHandler handler})> _pendingRequests = [
  ];

  ApiInterceptors(this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    log('onRequest',name: 'ApiInterceptors');
    final token = await SecureStorageHelper.readFromSecureStorage(key: SecureStorageHelper.tokenKey);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    log('onError', name: 'ApiInterceptors');

    // Only attempt refresh on 401 Unauthorized
    if (err.response?.statusCode == 401) {
      // If the error comes from the refresh token endpoint itself, don't retry (prevents infinite loops)
      if (err.requestOptions.path == Endpoints.refreshToken) {
        log('refresh token failed', name: 'ApiInterceptors');
        await _forceLogout();
        return handler.reject(err);
      }
      log('error not 401 1', name: 'ApiInterceptors');
      await _refreshToken(err, handler);
    } else {
      log('error not 401 2', name: 'ApiInterceptors');
      handler.next(err);
    }
  }

  Future<void> _refreshToken(DioException originalError, ErrorInterceptorHandler handler) async {
    // If already refreshing, queue this request
    if (_isRefreshing) {
      _pendingRequests.add(
          (options: originalError.requestOptions, handler: handler));
      return;
    }

    _isRefreshing = true;

    try {
      final refreshToken = await SecureStorageHelper.readFromSecureStorage(key: SecureStorageHelper.refreshTokenKey);
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

        // FIXED: Save to the correct keys
        await SecureStorageHelper.addToSecureStorage(
            key: SecureStorageHelper.tokenKey, value: newToken);
        await SecureStorageHelper.addToSecureStorage(
            key: SecureStorageHelper.refreshTokenKey, value: newRefreshToken);

        // 1. Retry the original request that triggered the refresh
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

  Future<void> _retryRequest(RequestOptions requestOptions, ErrorInterceptorHandler handler) async {
    final newToken = await SecureStorageHelper.readFromSecureStorage(key: SecureStorageHelper.tokenKey);

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
    await SecureStorageHelper.storage.deleteAll();

    // TODO: Add your navigation logic here, e.g.,
    // getIt<AppRouter>().router.go(Routes.login);
  }
}