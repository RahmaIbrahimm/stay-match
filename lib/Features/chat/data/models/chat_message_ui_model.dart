import 'package:stay_match/Features/chat/data/models/start_chat_response.dart';

enum MessageStatus { sending, sent, failed }

class ChatMessageUI {
  final Messages message;
  MessageStatus status;
  final String? tempId;

  ChatMessageUI({
    required this.message,
    this.status = MessageStatus.sent,
    this.tempId,
  });
}