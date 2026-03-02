import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:stay_match/core/errors/failures.dart';
import 'package:stay_match/core/networking/api_service.dart';
import 'package:stay_match/features/auth/data/models/forget_password_response.dart';
import 'package:stay_match/features/auth/data/models/login_response.dart';
import 'package:stay_match/features/auth/data/models/login_with_google_response.dart';
import 'package:stay_match/features/auth/data/models/reset_password_response.dart';
import 'package:stay_match/features/auth/data/models/verify_code_response.dart';

import '../../../../core/networking/endpoints.dart';
import 'auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiService apiService;

  AuthRepoImpl(this.apiService);

  @override
  Future<Either<Failure, LoginResponse>> login({
    required String email,
    required String password,
  }) async {
    try {
      var response = await apiService.post(
        Endpoints.login,
        data: {'email': email, 'password': password},
      );
      return right(LoginResponse.fromJson(response));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }

  @override
  String? emailValidator({String? email}) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    return null;
  }

  @override
  String? passwordValidator({String? password}) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  @override
  Future<Either<Failure, ForgetPasswordResponse>> sendVerificationCode({
    required String email,
  }) async {
    try {
      var response = await apiService.post(
        Endpoints.forgetPassword,
        data: {'email': email},
      );
      return right(ForgetPasswordResponse.fromJson(response));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, VerifyCodeResponse>> verifyOTP({
    required String code,
    required String email,
  }) async {
    try {
      var response = await apiService.post(
        Endpoints.verifyCode,
        data: {"email": email, "code": code},
      );
      return right(VerifyCodeResponse.fromJson(response));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, ResetPasswordResponse>> resetPassword({
    required String password,
    required String confirmPassword,
    required String userId,
  }) async {
    try {
      var response = await apiService.post(
        Endpoints.resetPassword,
        data: {
          "userId": userId,
          "newPassword": password,
          "confirmPassword": confirmPassword,
        },
      );
      return right(ResetPasswordResponse.fromJson(response));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, LoginWithGoogleResponse>> loginWithGoogle({
    required String idToken,
  }) async {
    try {
      var response = await apiService.post(
        Endpoints.googleLogin,
        data: {"idToken": idToken},
      );
      print('id token : $idToken');
      return right(LoginWithGoogleResponse.fromJson(response));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }
}