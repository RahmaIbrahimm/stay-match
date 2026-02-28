import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:stay_match/core/errors/failures.dart';
import 'package:stay_match/core/networking/api_service.dart';
import 'package:stay_match/features/auth/data/models/forget_password_response.dart';
import 'package:stay_match/features/auth/data/models/login_response.dart';

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
    String? email,
  }) async {
    try {
      var response = await apiService.post(
        Endpoints.forgetPassword,
        data: {'email': email},
      );
    ForgetPasswordResponse forgetPasswordResponse = ForgetPasswordResponse.fromJson(response);
    return right(forgetPasswordResponse);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }
}