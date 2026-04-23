import 'package:dartz/dartz.dart';
import 'package:stay_match/core/errors/failures.dart';

import '../models/all_apartments.dart';
import '../models/apartment_details_response.dart';

abstract class ApartmentRepo {
  Future<Either<Failure, AllApartmentsResponse>> getAllApartments({
    String? start,
    int? monthsCount,
    String? government,
    bool? allowsFamilies,
    bool? allowsChildren,
    bool? allowsStudents,
    bool? allowsWorkers,
    String? workerGender,
    String? studentGender,
    double? userLat,
    double? userLng,
    bool orderByOldest = false,
    bool onlyAvailable = false,
    num? page = 1,
    num? pageSize = 5,
  });
  Future<Either<Failure, ApartmentDetailsResponse>> getApartmentDetail({
    required int id,
  });
}