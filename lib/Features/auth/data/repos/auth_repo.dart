import 'package:dartz/dartz.dart';
import 'package:stay_match/core/errors/failures.dart';
import 'package:stay_match/features/auth/data/models/forget_password_response.dart';
import 'package:stay_match/features/auth/data/models/reset_password_response.dart';

import '../models/login_response.dart';
import '../models/verify_code_response.dart';

abstract class AuthRepo {
  Future<Either<Failure, LoginResponse>> login({
    required String email,
    required String password,
  });

  // ========== login  =========
  String? emailValidator({String? email});

  String? passwordValidator({String? password});

  // ========= forget password =========
  Future<Either<Failure, ForgetPasswordResponse>> sendVerificationCode({
    required String email,
  });
  // ========== confirm password ========
  Future<Either<Failure,VerifyCodeResponse>> verifyOTP({required String code,required String email});
  Future<Either<Failure,ResetPasswordResponse>> resetPassword({required String password,required String confirmPassword,required String userId});
}