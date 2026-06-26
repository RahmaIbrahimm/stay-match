import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:stay_match/core/data/models/one_property_match_response.dart';
import 'package:stay_match/core/data/repos/global_repo.dart';
import 'package:stay_match/core/errors/failures.dart';
import 'package:stay_match/core/networking/api_service.dart';
import 'package:stay_match/core/utils/secure_storage_helper.dart';

import '../../networking/endpoints.dart';
import '../../utils/service_locator.dart';

class GlobalRepoImpl extends GlobalRepo{
  final Dio dio;
  final ApiService? apiService;
  GlobalRepoImpl({this.apiService}) : dio = Dio() {
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        responseUrl: true,
        error: true,
      ),
    );
  }

  @override
  Future<Either<Failure, OnePropertyMatchResponse>> getPropertyMatchResponse({required int propertyId}) async {
    try {
      var token = await getIt.get<SecureStorageHelper>().getUserToken();
      var response = await dio.get(
        Endpoints.getMatchProperty(propertyId),
        options: Options(headers: {'Authorization': token})
      );
      return right(OnePropertyMatchResponse.fromJson(response));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }}

}