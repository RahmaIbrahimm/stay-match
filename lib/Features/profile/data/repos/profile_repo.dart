import 'package:dartz/dartz.dart';
import 'package:stay_match/Features/profile/data/models/delete_account_response.dart';
import 'package:stay_match/Features/profile/data/models/profile_response.dart';
import 'package:stay_match/Features/profile/data/models/update_profile_request.dart';
import 'package:stay_match/Features/profile/data/models/upload_profile_picture_response.dart';
import 'package:stay_match/core/errors/failures.dart';

import '../models/update_profile_response.dart';

abstract class ProfileRepo {
  Future<Either<Failure,ProfileResponse>> getProfile();
  Future<Either<Failure,UpdateProfileResponse>> updateProfile(
      {required UpdateProfileRequest request});

  Future<Either<Failure, UploadProfilePictureResponse>> uploadProfileImg({
    required String imageFile,
  });

  Future<Either<Failure, UploadProfilePictureResponse>> updateProfileImg({
    required String imageFile,
  });
  Future<Either<Failure,DeleteAccountResponse>> deleteAccount();
}