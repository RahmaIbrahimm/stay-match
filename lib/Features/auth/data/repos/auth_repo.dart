import 'package:dartz/dartz.dart';
import 'package:stay_match/core/errors/failures.dart';
import 'package:stay_match/features/auth/data/models/forget_password_response.dart';

import '../models/login_response.dart';

abstract class AuthRepo {
  Future<Either<Failure, LoginResponse>> login({
    required String email,
    required String password,
  });

  // ========== login  =========
  String? emailValidator({String? email});

  String? passwordValidator({String? password});
  // ========= forget password =========
  Future<Either<Failure,ForgetPasswordResponse>> sendVerificationCode({String? email});
}