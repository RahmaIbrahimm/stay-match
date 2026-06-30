import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:stay_match/core/data/models/one_property_match_response.dart';
import 'package:stay_match/core/data/repos/global_repo.dart';
import 'package:stay_match/core/errors/failures.dart';
import 'package:stay_match/core/networking/api_service.dart';

import '../../../Features/profile/data/models/compatibility_profile_response.dart';
import '../../networking/endpoints.dart';

class GlobalRepoImpl extends GlobalRepo{
  ApiService apiService;

  GlobalRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, OnePropertyMatchResponse>> getPropertyMatchResponse({required int propertyId}) async {
    try {
      var response = await apiService.get(
        Endpoints.getMatchProperty(propertyId),
      );
      return right(OnePropertyMatchResponse.fromJson(response));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }}

  @override
  Future<Either<Failure,
      CompatibilityProfileResponse>> compatibilityProfile() async {
    try {
      var response = await apiService.get(
          'https://staymatch-recommendation-service-production.up.railway.app/profile/questionnaire');
      return right(CompatibilityProfileResponse.fromJson(response));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }
}