import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:stay_match/Features/chat/data/models/mark_read.dart';
import 'package:stay_match/Features/chat/data/models/my_chats.dart';
import 'package:stay_match/Features/chat/data/models/send_message_response.dart';
import 'package:stay_match/Features/chat/data/models/start_chat_response.dart';
import 'package:stay_match/core/errors/failures.dart';

import '../../../../core/networking/api_service.dart';
import '../../../../core/networking/endpoints.dart';
import 'chat_repo.dart';

class ChatRepoImpl extends ChatRepo {
  ApiService apiService;

  ChatRepoImpl(this.apiService);

  @override
  Future<Either<Failure, MyChats>> getMyChats() async {
    try {
      var response = await apiService.get(Endpoints.myChats);
      return right(MyChats.fromJson(response));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, StartChatResponse>> startChat({
    required String otherUserId,
  }) async {
    try {
      var response = await apiService.post(
        Endpoints.startChat,
        data: {'otherUserId': otherUserId},
        // data: {},
      );
      return right(StartChatResponse.fromJson(response));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, MarkRead>> markAsRead({required int chatId}) async {
    try {
      var response = await apiService.post(
        Endpoints.markRead,
        queryParameters: {'chatId': chatId},
      );
      return right(MarkRead.fromJson(response));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, SendMessageResponse>> sendMessage({
    required int chatId,
    String? content,
    String? filePath,
    required String type,
  }) async {
    try {
      Map<String, dynamic> dataMap = {
        'ChatId': chatId,
        'Type': type,
      };
      dataMap['Content'] = content ?? "";
      if (filePath != null && filePath.isNotEmpty) {
        dataMap['File'] = await MultipartFile.fromFile(
          filePath,
          filename: filePath.split('/').last,
        );
      }
      FormData formData = FormData.fromMap(dataMap);

      var response = await apiService.post(
        Endpoints.sendMessage,
        data: formData,
      );
      return right(SendMessageResponse.fromJson(response));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}