import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_match/Features/chatbot/data/repos/chatbot_repo.dart';

import '../../data/models/chat_message_item.dart';

part 'chatbot_state.dart';

class ChatbotCubit extends Cubit<ChatbotState> {
  final ChatbotRepo chatbotRepo;

  ChatbotCubit({required this.chatbotRepo}) : super(const ChatbotInitial());

  /// Sends [text] as a user message, appends it immediately, then fetches
  /// the bot's reply.
  Future<void> sendMessage(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    final userMessage = ChatMessageItem(
      sender: ChatSender.user,
      text: trimmed,
      timestamp: DateTime.now(),
    );

    final messagesWithUser = [...state.messages, userMessage];
    emit(ChatbotUpdated(messages: messagesWithUser, isSending: true));

    final result = await chatbotRepo.getChatbotResponse(
      message: trimmed,
    );

    result.fold(
      (failure) {
        emit(
          ChatbotError(
            messages: messagesWithUser,
            errMessage: failure.errMessage,
            isSending: false,
          ),
        );
      },
      (response) {
        final botMessage = ChatMessageItem(
          sender: ChatSender.bot,
          text: response.reply,
          timestamp: DateTime.now(),
          suggestions: response.suggestions ?? const [],
          results: response.results ?? const [],
          pagination: response.pagination,
        );

        emit(
          ChatbotUpdated(
            messages: [...messagesWithUser, botMessage],
            isSending: false,
          ),
        );
      },
    );
  }

  /// Tapping a suggestion chip behaves exactly like typing its value.
  void sendSuggestion(String value) => sendMessage(value);

  /// Removes the last (failed) user message and resends it.
  void retryLastMessage() {
    final messages = state.messages;
    if (messages.isEmpty) return;

    final lastMessage = messages.last;
    if (lastMessage.sender != ChatSender.user || lastMessage.text == null) {
      return;
    }

    final withoutLast = messages.sublist(0, messages.length - 1);
    emit(ChatbotUpdated(messages: withoutLast, isSending: false));
    sendMessage(lastMessage.text!);
  }

  /// Clears the conversation and starts a brand new session.
  void clearChat() {
    emit(const ChatbotInitial());
  }
}