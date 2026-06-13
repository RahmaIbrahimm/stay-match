import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:stay_match/Features/home/data/models/properties_general_search.dart';
import 'package:stay_match/core/errors/failures.dart';
import 'package:stay_match/core/networking/api_service.dart';

import '../../../../core/networking/endpoints.dart';
import 'home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  ApiService apiService;
  HomeRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, PropertiesGeneralSearch>> homeSearch({
    required String type,
    int? page = 1,
    int? pageSize = 10,
    required String q,
  }) async {
    try {
      var response = await apiService.get(
        Endpoints.homeSearch,
        queryParameters: {
          'type': type,
          'q': q,
          'page': page,
          'pageSize': pageSize
        },
      );
      return right(PropertiesGeneralSearch.fromJson(response));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }
}