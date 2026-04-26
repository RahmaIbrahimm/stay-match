import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart'; // Add this package
import 'package:stay_match/Features/profile/data/models/delete_account_response.dart';
import 'package:stay_match/Features/profile/data/models/profile_response.dart';
import 'package:stay_match/Features/profile/data/models/update_profile_request.dart';
import 'package:stay_match/Features/profile/data/models/update_profile_response.dart';
import 'package:stay_match/Features/profile/data/models/upload_profile_picture_response.dart';
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

  @override
  Future<Either<Failure, UploadProfilePictureResponse>> uploadProfileImg({
    required String imageFile,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'ImageFile': await MultipartFile.fromFile(
          imageFile,
          contentType: MediaType('image', 'jpeg'),
        ),
      });

      final response = await apiService.post(
        Endpoints.uploadProfilePic,
        data: formData,
      );
      return Right(UploadProfilePictureResponse.fromJson(response));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UploadProfilePictureResponse>> updateProfileImg({
    required String imageFile,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'ImageFile': await MultipartFile.fromFile(
          imageFile,
          contentType: MediaType('image', 'jpeg'),
        ),
      });

      final response = await apiService.put(
        Endpoints.updateProfilePic,
        data: formData,
      );
      return Right(UploadProfilePictureResponse.fromJson(response));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DeleteAccountResponse>> deleteAccount() async {
    try {
      var response = await apiService.delete(Endpoints.deleteAccount);
      return right(DeleteAccountResponse.fromJson(response));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }
}