import 'package:dartz/dartz.dart';
import 'package:stay_match/core/data/models/one_property_match_response.dart';
import 'package:stay_match/core/errors/failures.dart';

import '../../../Features/profile/data/models/compatibility_profile_response.dart';

abstract class GlobalRepo {
  Future<Either<Failure,OnePropertyMatchResponse>> getPropertyMatchResponse({required int propertyId});
  Future<Either<Failure,CompatibilityProfileResponse>> compatibilityProfile();

}