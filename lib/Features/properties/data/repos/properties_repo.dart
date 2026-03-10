import 'package:dartz/dartz.dart';
import 'package:stay_match/core/errors/failures.dart';
import 'package:stay_match/features/properties/data/models/get_all_apartments.dart';

abstract class PropertiesRepo {
  Future<Either<Failure, GetAllApartments>> getAllApartments({
    String? start,
    int? monthsCount,
    String? government,
    bool? allowsFamilies,
    bool? allowsChildren,
    bool? allowsStudents,
    String? workerGender,
    double? userLat,
    double? userLng,
    bool orderByOldest = false,
    bool onlyAvailable = false,
  });
}