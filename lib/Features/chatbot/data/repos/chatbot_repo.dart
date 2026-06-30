import 'package:dartz/dartz.dart';
import 'package:stay_match/Features/chatbot/data/models/chatbot_response.dart';
import 'package:stay_match/core/errors/failures.dart';

abstract class ChatbotRepo {
  Future<Either<Failure,ChatbotResponse>> getChatbotResponse({required String message});
}