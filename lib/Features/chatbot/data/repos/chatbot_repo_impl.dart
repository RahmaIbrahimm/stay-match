import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:stay_match/Features/chatbot/data/models/chatbot_response.dart';
import 'package:stay_match/Features/chatbot/data/repos/chatbot_repo.dart';
import 'package:stay_match/core/errors/failures.dart';
import 'package:stay_match/core/networking/api_interceptors.dart';
import 'package:stay_match/core/utils/secure_storage_helper.dart';
import 'package:stay_match/core/utils/secure_storage_keys.dart';
import 'package:stay_match/core/utils/service_locator.dart';

import '../../../../core/networking/endpoints.dart';

class ChatbotRepoImpl extends ChatbotRepo {
  final Dio dio;

  ChatbotRepoImpl() : dio = Dio() {
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
    dio.interceptors.add(ApiInterceptors(dio));
  }

  @override
  Future<Either<Failure, ChatbotResponse>> getChatbotResponse({
    required String message,
  }) async {
    try {
      String? token = await getIt
          .get<SecureStorageHelper>()
          .readFromSecureStorage(key: SecureStorageKeys.tokenKey);
      var response = await dio.post(
        Endpoints.chatBot,
        data: {'message': message},
        options: Options(headers: {'Authorization': 'Bearer ${token}'},),
      );
      return right(ChatbotResponse.fromJson(response.data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }
}