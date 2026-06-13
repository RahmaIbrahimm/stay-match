import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:stay_match/Features/other_user_profile/data/models/other_user_profile_response.dart';

import 'package:stay_match/core/errors/failures.dart';
import 'package:stay_match/core/networking/api_service.dart';

import '../../../../core/networking/endpoints.dart';
import 'other_user_profile_repo.dart';

class OtherUserProfileRepoImpl extends OtherUserProfileRepo {
  ApiService apiService;
  OtherUserProfileRepoImpl({required this.apiService});
  @override
  Future<Either<Failure, OtherUserProfileResponse>> getOtherUserProfile({required String userId}) async{
    try {
      var response = await apiService.get(
        Endpoints.otherUserProfile(userId),
      );
      return right(OtherUserProfileResponse.fromJson(response));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }
  
}