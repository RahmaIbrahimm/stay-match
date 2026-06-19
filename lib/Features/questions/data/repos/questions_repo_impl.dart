import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:stay_match/Features/questions/data/models/answer_questions_request.dart';
import 'package:stay_match/Features/questions/data/models/answer_questions_response.dart';
import 'package:stay_match/Features/questions/data/models/get_questions_response.dart';
import 'package:stay_match/Features/questions/data/repos/questions_repo.dart';
import 'package:stay_match/core/errors/failures.dart';

import '../../../../core/networking/endpoints.dart';
import '../../../../core/utils/secure_storage_helper.dart';
import '../../../../core/utils/secure_storage_keys.dart';
import '../../../../core/utils/service_locator.dart';

class QuestionsRepoImpl extends QuestionsRepo {
  final Dio dio;

  QuestionsRepoImpl() : dio = Dio() {
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
  Future<Either<Failure, GetQuestionsResponse>> getQuestions() async {
    try {
      var response = await dio.get(Endpoints.getQuestions);
      return right(GetQuestionsResponse.fromJson(response.data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, AnswerQuestionsResponse>> answerQuestions({
    required AnswerQuestionsRequest request,
  }) async {
    try {
      String? token = await getIt
          .get<SecureStorageHelper>()
          .readFromSecureStorage(key: SecureStorageKeys.tokenKey);
      var response = await dio.post(
        Endpoints.answerQuestions,
        options: Options(headers: {'Authorization': token,}),
        data:  request.toJson(),
      );
      return right(AnswerQuestionsResponse.fromJson(response));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }
}