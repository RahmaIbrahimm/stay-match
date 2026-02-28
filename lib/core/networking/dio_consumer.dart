import 'package:dio/dio.dart';
import 'package:stay_match/core/networking/api_interceptors.dart';
import 'package:stay_match/core/networking/api_service.dart';
import 'package:stay_match/core/networking/endpoints.dart';

import '../errors/failures.dart';

class DioConsumer extends ApiService {
  final Dio dio;

  DioConsumer(this.dio) {
    dio.options.baseUrl = Endpoints.baseUrl;
    dio.interceptors.add(ApiInterceptors());
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        error: true,

        requestUrl: true,
        responseUrl: true,
        responseBody: true,
        responseHeader: true,
      ),
    );
  }

  @override
  Future<dynamic> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<dynamic> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<dynamic> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.patch(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}