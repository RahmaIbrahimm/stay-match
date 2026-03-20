import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:stay_match/core/networking/dio_consumer.dart';
import 'package:stay_match/core/utils/secure_storage_helper.dart';
import 'package:stay_match/core/utils/service_locator.dart';
import 'package:stay_match/features/auth/data/repos/auth_repo_impl.dart';

class ApiInterceptors extends Interceptor {
  Dio dio;
  ApiInterceptors({required this.dio});
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await SecureStorageHelper.readFromSecureStorage(
        key: SecureStorageHelper.tokenKey);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
      log('Token added to request: $token');
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      log('Access token expired, trying refresh...');

      final refreshToken = await SecureStorageHelper.storage.read(
          key: SecureStorageHelper.refreshTokenKey);

      if (refreshToken == null) {
        log('No refresh token → cannot refresh');
        return handler.next(err);
      }

      try {
        final response = await AuthRepoImpl(getIt.get<DioConsumer>())
            .refreshToken(refreshToken: refreshToken);

        String? newAccessToken;
        String? newRefreshToken;

        response.fold(
              (failure) {
            log('Refresh failed: ${failure.errMessage}');
          },
              (refreshResponse) {
            newAccessToken = refreshResponse.token;
            newRefreshToken = refreshResponse.refreshToken;
            log('Token refreshed successfully: $newAccessToken');
          },
        );

        if (newAccessToken == null) {
          return handler.next(err);
        }

        // Save new tokens
        await SecureStorageHelper.storage.write(
            key: SecureStorageHelper.tokenKey, value: newAccessToken);
        await SecureStorageHelper.storage.write(
            key: SecureStorageHelper.refreshTokenKey, value: newRefreshToken);

        // Retry original request
        final requestOptions = err.requestOptions;
        requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
        final cloneResponse = await dio.fetch(requestOptions);

        return handler.resolve(cloneResponse);
      } catch (e) {
        log('Refresh failed → logout user');
        await SecureStorageHelper.storage.deleteAll();
        return handler.next(err);
      }
    } else {
      handler.next(err); // pass non-401 errors
    }
  }
}
// class ApiInterceptors extends Interceptor {
//   @override
//   void onRequest(RequestOptions options,
//       RequestInterceptorHandler handler) async {
//     final token = await SecureStorageHelper.readFromSecureStorage(
//         key: SecureStorageHelper.tokenKey);
//
//     if (token != null) {
//       options.headers['Authorization'] = 'Bearer $token';
//       // options.headers['Authorization'] = 'Bearer $token';
//       log('token in request: $token');
//     }
//
//     handler.next(options);
//   }
//
//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) async {
//     if (err.response?.statusCode == 401) {
//       log('Access token expired, trying refresh...');
//
//       final refreshToken = await SecureStorageHelper.storage.read(
//         key: SecureStorageHelper.refreshTokenKey,
//       );
//
//       if (refreshToken == null) {
//         return handler.next(err); // logout case
//       }
//
//       try {
//         var  newAccessToken ;
//         var  newRefreshToken ;
//         var response = await AuthRepoImpl(getIt.get<DioConsumer>())
//             .refreshToken(refreshToken: refreshToken);
//         response.fold(
//               (failure) {
//             // handle failure
//             print("Refresh failed: ${failure.errMessage}");
//           },
//               (refreshResponse) {
//              newAccessToken = refreshResponse.token;
//             newRefreshToken = refreshResponse.refreshToken;
//             // handle success
//             print("New token: ${refreshResponse.token}");
//           },
//         );
//
//
//         // ✅ Save new tokens
//         await SecureStorageHelper.storage.write(
//           key: SecureStorageHelper.tokenKey,
//           value: newAccessToken,
//         );
//
//         await SecureStorageHelper.storage.write(
//           key: SecureStorageHelper.refreshTokenKey,
//           value: newRefreshToken,
//         );
//
//         log('Token refreshed successfully');
//
//         // 🔥 Retry original request
//         final requestOptions = err.requestOptions;
//
//         requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
//
//         final cloneResponse = await dio.fetch(requestOptions);
//
//         return handler.resolve(cloneResponse);
//       } catch (e) {
//         log('Refresh failed → logout user');
//
//         // Optional: clear storage
//         await SecureStorageHelper.storage.deleteAll();
//
//         return handler.next(err);
//       }
//     }
//
//     return handler.next(err);
//   }
// }