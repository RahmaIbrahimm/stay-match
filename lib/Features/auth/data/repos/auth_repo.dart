import 'package:dartz/dartz.dart';
import 'package:stay_match/core/errors/exceptions.dart';

abstract class AuthRepo {
  Future<Either<Exceptions,Future<void>>> signUp();
  Future<Either<Exceptions,Future<void>>> login();
}