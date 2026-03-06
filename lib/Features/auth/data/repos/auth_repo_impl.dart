import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:stay_match/core/errors/failures.dart';
import 'package:stay_match/core/networking/api_service.dart';
import 'package:stay_match/features/auth/data/models/forget_password_response.dart';
import 'package:stay_match/features/auth/data/models/login_response.dart';
import 'package:stay_match/features/auth/data/models/login_with_google_response.dart';
import 'package:stay_match/features/auth/data/models/register_response.dart';
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
  String? passwordMatchValidator({
    required String? password,
    required String? confirmPassword,
  }) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm your password';
    }

    if (password != confirmPassword) {
      return 'Passwords do not match';
    }

    return null;
  }
  @override
  String? nullFieldValidator({String? text}) {
    if (text?.trim() == null || text!.trim().isEmpty) {
      return 'Required';
    }
    return null;
  }

  @override
  String? emailValidator({String? email}) {
    email = email?.trim();
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
    );

    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address';
    }

    if (!email.contains('.') || email.startsWith('.') || email.endsWith('.')) {
      return 'Please enter a valid email address';
    }

    if (email.split('@').length != 2) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  @override
  String? passwordValidator({String? password}) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }

    if (password.length < 6) {
      return 'Password must be at least 6 characters long';
    }

    if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!password.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!password.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  @override
  Future<Either<Failure, RegisterResponse>> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required String genderType,
    required String birthDate,
    required String city,
  }) async {
    try {
      var response = await apiService.post(
        Endpoints.register,
        data: {
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "password": password,
          "confirmPassword": confirmPassword,
          "genderType": genderType,
          "birthDate": birthDate,
          "city": city,
        },
      );
      return right(RegisterResponse.fromJson(response));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
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
      print('id token impl print: $idToken');
      return right(LoginWithGoogleResponse.fromJson(response));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }
}