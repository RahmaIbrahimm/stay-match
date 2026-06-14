import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:stay_match/Features/saved/data/models/my_saved_response.dart';
import 'package:stay_match/Features/saved/data/models/room_toggle_saved_response.dart';
import 'package:stay_match/Features/saved/data/models/saved_count_response.dart';
import 'package:stay_match/Features/saved/data/models/toggle_saved_response.dart';
import 'package:stay_match/Features/saved/data/repos/saved_properties_repo.dart';
import 'package:stay_match/core/errors/failures.dart';
import 'package:stay_match/core/networking/api_service.dart';

import '../../../../core/networking/endpoints.dart';
import '../models/recommended_properties_response.dart';

class SavedPropertiesRepoImpl extends SavedPropertiesRepo {
  ApiService apiService;

  SavedPropertiesRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, MySavedResponse>> getSavedProperties({
    String? type,
    int page = 1,
    int pageSize = 10,
    String? search,
  }) async {
    try {
      final response = await apiService.get(
        Endpoints.mySavedProperties,
        queryParameters: {
          'type': type,
          'page': page,
          'pageSize': pageSize,
          'search': search,
        },
        data: {},
      );

      return Right(MySavedResponse.fromJson(response));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, SavedCountResponse>> getSavedPropertiesCount() async {
    try {
      final response = await apiService.get(
        Endpoints.savedPropertiesCount,
        data: {},
      );

      return Right(SavedCountResponse.fromJson(response));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, ToggleSavedResponse>> toggleSavedApartment({
    required int propertyId,
  }) async {
    try {
      final response = await apiService.post(
        Endpoints.toggleSavedApartment,
        data: {'propertyId': propertyId},
      );

      return Right(ToggleSavedResponse.fromJson(response));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, RoomToggleSavedResponse>> toggleSavedRoom({
    required int propertyId,
    required int roomId,
  }) async {
    try {
      final response = await apiService.post(
        Endpoints.toggleSavedRoom,
        data: {'propertyId': propertyId, 'roomId': roomId},
      );

      return Right(RoomToggleSavedResponse.fromJson(response));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }
  @override
  Future<Either<Failure, RecommendedPropertiesResponse>> getRecommendedProperties({int limit = 2})async {
    try {
      // We pass the serialized JSON directly to the data body
      final response = await apiService.get(
          Endpoints.recommendedProperties,
          data: {
            'limit':limit
          }
      );

      return Right(RecommendedPropertiesResponse.fromJson(response));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }
}