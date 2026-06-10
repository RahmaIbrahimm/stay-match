import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:stay_match/core/errors/failures.dart';
import 'package:stay_match/core/networking/api_service.dart';

import '../../../../../../../core/networking/endpoints.dart';
import '../models/all_apartments_response.dart';
import '../../../shared/models/property_details_response.dart';
import 'apartment_repo.dart';

class ApartmentRepoImpl extends ApartmentRepo {
  ApiService apiService;

  ApartmentRepoImpl({required this.apiService});
  bool orderByOldest = false;
  bool onlyAvailable = false;
  @override
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
          'studentGender': studentGender,
          'allowsWorkers': allowsWorkers,
          'userLat': userLat,
          'userLng': userLng,
          'orderByOldest': orderByOldest,
          'onlyAvailable': onlyAvailable,
          'page': page,
          'pageSize': pageSize,
        },
      );
      return right(AllApartmentsResponse.fromJson(response));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, PropertyDetailsResponse>> getApartmentDetail({
    required int id,
  }) async {
    try {
      var response = await apiService.get(
        '${Endpoints.getPropertyDetails}$id',
      );
      return right(PropertyDetailsResponse.fromJson(response));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }
}