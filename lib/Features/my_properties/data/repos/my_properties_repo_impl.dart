import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:stay_match/Features/my_properties/data/models/my_properties_response.dart';

import 'package:stay_match/core/errors/failures.dart';
import 'package:stay_match/core/networking/api_service.dart';

import '../../../../core/networking/endpoints.dart';
import 'my_properties_repo.dart';

class MyPropertiesRepoImpl extends MyPropertiesRepo{
  ApiService apiService;
  MyPropertiesRepoImpl({required this.apiService});
  @override
  Future<Either<Failure, MyPropertiesResponse>> getMyProperties({String? filter = 'all', int? page = 1, int? pageSize = 10}) async {
    try {
      var response = await apiService.get(
        Endpoints.myProperties,
        queryParameters: {
          'filter':filter,
          'page': page,
          'pageSize': pageSize,
        },
      );
      return right(MyPropertiesResponse.fromJson(response));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }
}