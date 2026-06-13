import 'package:dartz/dartz.dart';
import 'package:stay_match/Features/my_properties/data/models/my_properties_response.dart';
import 'package:stay_match/core/errors/failures.dart';

abstract class MyPropertiesRepo{
  Future<Either<Failure,MyPropertiesResponse>> getMyProperties({String? filter,int? page,int? pageSize});
  Future<Either<Failure, Unit>> deleteProperty({required int id});

}