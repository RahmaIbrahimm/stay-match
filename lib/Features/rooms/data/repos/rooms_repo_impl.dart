import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:stay_match/core/errors/failures.dart';
import 'package:stay_match/core/networking/api_service.dart';
import 'package:stay_match/core/networking/endpoints.dart';
import 'package:stay_match/features/rooms/data/repos/rooms_repo.dart';

import '../models/get_all_rooms.dart';

class RoomsRepoImpl extends RoomsRepo {
  ApiService apiService;

  RoomsRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, GetAllRooms>> getAllRooms({
    String? start,
    num? monthsCount,
    String? government,
    bool? allowsFamilies,
    bool? allowsChildren,
    bool? allowsStudents,
    bool? allowsWorkers,
    String? studentGender,
    String? workerGender,
    double? userLat,
    double? userLng,
    bool orderByOldest = false,
    bool onlyAvailable = false,
    num? page = 1,
    num? pageSize = 10
  }) async {
    try {
      var response = await apiService.get(
        Endpoints.getAllRooms,
        queryParameters: {
          'start': start,
          'monthsCount': monthsCount,
          'government': government,
          'allowsFamilies': allowsFamilies,
          'allowsChildren': allowsChildren,
          'allowsStudents': allowsStudents,
          'allowsWorkers': allowsWorkers,
          'studentGender': studentGender,
          'workerGender': workerGender,
          'userLat': userLat,
          'userLng': userLng,
          'orderByOldest': orderByOldest,
          'onlyAvailable': onlyAvailable,
          'page' : page,
          'pageSize':pageSize
        },
      );
      return right(GetAllRooms.fromJson(response));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }
}