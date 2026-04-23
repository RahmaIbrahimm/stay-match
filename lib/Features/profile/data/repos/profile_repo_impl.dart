import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:stay_match/Features/profile/data/models/profile_response.dart';
import 'package:stay_match/Features/profile/data/models/update_profile_request.dart';
import 'package:stay_match/Features/profile/data/models/update_profile_response.dart';
import 'package:stay_match/core/errors/failures.dart';
import 'package:stay_match/core/networking/api_service.dart';

import '../../../../core/networking/endpoints.dart';
import 'profile_repo.dart';

class ProfileRepoImpl extends ProfileRepo {
  ApiService apiService;

  ProfileRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, ProfileResponse>> getProfile() async {
    try {
      var response = await apiService.get(Endpoints.profileData);
      return right(ProfileResponse.fromJson(response));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, UpdateProfileResponse>> updateProfile({
    required UpdateProfileRequest request,
  }) async {
    try {
      var response = await apiService.put(
        Endpoints.updateProfile,
        data: request.toJson(),
      );
      return right(UpdateProfileResponse.fromJson(response));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }
}