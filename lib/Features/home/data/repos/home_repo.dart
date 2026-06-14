import 'package:dartz/dartz.dart';
import 'package:stay_match/Features/home/data/models/properties_general_search.dart';
import 'package:stay_match/core/errors/failures.dart';

abstract class HomeRepo {
  // type : shared, entire
  Future<Either<Failure, PropertiesGeneralSearch>> homeSearch({required String type, int? page = 1, int? pageSize = 10, required String q });
}