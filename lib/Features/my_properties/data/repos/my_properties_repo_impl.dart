import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:stay_match/Features/my_properties/data/models/my_properties_response.dart';
import 'package:stay_match/core/errors/failures.dart';
import 'package:stay_match/core/networking/api_service.dart';

import '../../../../core/networking/endpoints.dart';
import 'my_properties_repo.dart';

class MyPropertiesRepoImpl extends MyPropertiesRepo{
  ApiService apiService;
  MyPropertiesRepoImpl({required this.apiService});
  @override
  Future<Either<Failure, MyPropertiesResponse>> getMyProperties({String? filter = 'all', int? page = 1, int? pageSize = 10}) async {
    try {
      var response = await apiService.get(
        Endpoints.myProperties,
        queryParameters: {
          'filter':filter,
          'page': page,
          'pageSize': pageSize,
        },
      );
      return right(MyPropertiesResponse.fromJson(response));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }
  @override
  Future<Either<Failure, Unit>> deleteProperty({required int id}) async {
    try {
      final response = await apiService.delete(
        Endpoints.deleteProperty(id),
      );

      // 1. Handle the 204 "No Content" empty string case from your apiService wrapper
      if (response == "" || response == null) {
        debugPrint("✅ Property $id deleted successfully (Server returned 204 No Content).");
        return const Right(unit);
      }

      // 2. Fallback check: If apiService returned a standard Response object instead of a body string
      if (response is! String && (response.statusCode == 200 || response.statusCode == 204)) {
        return const Right(unit);
      }

      // 3. If it's a non-empty string that isn't success, it might be an actual error message
      if (response is String) {
        return Left(ServerFailure(response));
      }

      return Left(ServerFailure('Failed to delete property'));
    } catch (e) {
      debugPrint("🚨 Exception caught in repository: $e");
      return Left(ServerFailure(e.toString()));
    }
  }

}