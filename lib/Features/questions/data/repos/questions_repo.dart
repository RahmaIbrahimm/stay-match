import 'package:dartz/dartz.dart';
import 'package:stay_match/Features/questions/data/models/answer_questions_request.dart';
import 'package:stay_match/Features/questions/data/models/get_questions_response.dart';
import 'package:stay_match/Features/questions/data/models/answer_questions_response.dart';
import 'package:stay_match/core/errors/failures.dart';

abstract class QuestionsRepo {
  Future<Either<Failure,GetQuestionsResponse>> getQuestions();
  Future<Either<Failure,AnswerQuestionsResponse>> answerQuestions({required AnswerQuestionsRequest request});
}