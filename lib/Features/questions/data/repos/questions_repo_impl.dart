import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:stay_match/Features/questions/data/models/answer_questions_request.dart';
import 'package:stay_match/Features/questions/data/models/answer_questions_response.dart';
import 'package:stay_match/Features/questions/data/models/get_questions_response.dart';
import 'package:stay_match/Features/questions/data/repos/questions_repo.dart';
import 'package:stay_match/core/errors/failures.dart';
import 'package:stay_match/core/networking/api_service.dart';

import '../../../../core/networking/endpoints.dart';

class QuestionsRepoImpl extends QuestionsRepo {
  ApiService apiService;

  QuestionsRepoImpl({required this.apiService}) : super();
  @override
  Future<Either<Failure, GetQuestionsResponse>> getQuestions() async {
    try {
      var response = await apiService.get(Endpoints.getQuestions);
      return right(GetQuestionsResponse.fromJson(response));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, AnswerQuestionsResponse>> answerQuestions({
    required AnswerQuestionsRequest request,
  }) async {
    try {
      var response = await apiService.post(
        Endpoints.answerQuestions,
        data:  request.toJson(),
      );
      return right(AnswerQuestionsResponse.fromJson(response));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }
}