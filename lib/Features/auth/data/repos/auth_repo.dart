import 'package:dartz/dartz.dart';
import 'package:stay_match/core/errors/exceptions.dart';

import '../models/login_response.dart';

abstract class AuthRepo {
  Future<Either<Exceptions, LoginResponse>> login({
    required String email,
    required String password,
  });

  String? loginEmailValidator({String? email});

  String? loginPasswordValidator({String? password});

  void loginAccountValidation();
}