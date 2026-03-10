import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:stay_match/core/errors/failures.dart';
import 'package:stay_match/core/networking/api_service.dart';
import 'package:stay_match/features/properties/data/models/get_all_apartments.dart';

import '../../../../core/networking/endpoints.dart';
import 'properties_repo.dart';

class PropertiesRepoImpl extends PropertiesRepo {
  ApiService apiService;

  PropertiesRepoImpl({required this.apiService});

  @override
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
  }) async {
    try {
      var response = await apiService.get(
        Endpoints.getAllApartments,
        queryParameters: {
          'start': start,
          'monthsCount': monthsCount,
          'government': government,
          'allowsFamilies': allowsFamilies,
          'allowsChildren': allowsChildren,
          'allowsStudents': allowsStudents,
          'workerGender': workerGender,
          'userLat': userLat,
          'userLng': userLng,
          'orderByOldest': orderByOldest,
          'onlyAvailable': onlyAvailable,
        },
      );
      return right(GetAllApartments.fromJson(response));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }
}