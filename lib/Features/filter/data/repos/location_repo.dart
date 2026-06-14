import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/location_model.dart';

abstract class LocationRepo {
  Future<Either<Failure, List<Governorate>>> getGovernorates();
}