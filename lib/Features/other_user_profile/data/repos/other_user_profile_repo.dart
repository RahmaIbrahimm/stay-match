import 'package:dartz/dartz.dart';
import 'package:stay_match/Features/other_user_profile/data/models/other_user_profile_response.dart';
import 'package:stay_match/core/errors/failures.dart';

abstract class OtherUserProfileRepo {
  Future<Either<Failure,OtherUserProfileResponse>> getOtherUserProfile({required String userId });
}