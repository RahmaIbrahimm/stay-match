import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:stay_match/core/utils/secure_storage_helper.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Don't nest another onRequest here, just implement the logic directly
    _addTokenToHeaders(options);
    handler.next(options);
  }
  // Helper method to add token asynchronously
  void _addTokenToHeaders(RequestOptions options) {
    final token = SecureStorageHelper.token;


    // Add token to headers if it exists
    if (token != null && token.isNotEmpty) {
      // options.headers['Authorization'] = 'Bearer $token';
      options.headers['Authorization'] = 'Bearer $token';
      log('token in onrequest: $token');
    }
  }
}