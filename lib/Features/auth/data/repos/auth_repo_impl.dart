import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:stay_match/core/errors/exceptions.dart';
import 'package:stay_match/core/networking/api_service.dart';
import 'package:stay_match/features/auth/data/models/login_response.dart';

import '../../../../core/networking/endpoints.dart';
import 'auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiService apiService;

  AuthRepoImpl(this.apiService);
  
  @override
  Future<Either<Exceptions, LoginResponse>> login({
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
  String? loginEmailValidator({String? email}) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    return null;
  }

  @override
  String? loginPasswordValidator({String? password}) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  @override
  void loginAccountValidation() {
    // TODO: implement loginAccountValidation
  }


}