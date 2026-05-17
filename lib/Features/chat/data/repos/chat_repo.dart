import 'package:dartz/dartz.dart';
import 'package:stay_match/Features/chat/data/models/mark_read.dart';
import 'package:stay_match/Features/chat/data/models/my_chats.dart';
import 'package:stay_match/Features/chat/data/models/start_chat_response.dart';
import 'package:stay_match/core/errors/failures.dart';

import '../models/search_chats_response.dart';
import '../models/send_message_response.dart';

abstract class ChatRepo {
  Future<Either<Failure, MyChats>> getMyChats();

  Future<Either<Failure, StartChatResponse>> startChat({
    required String otherUserId,
  });

  Future<Either<Failure, MarkRead>> markAsRead({required int chatId});

  Future<Either<Failure, SendMessageResponse>> sendMessage({
    required int chatId,
    String? content,
    String? filePath,
    required String type,
  });

  Future<Either<Failure, SearchChatsResponse>> searchChats({
    required String search,
  });
}