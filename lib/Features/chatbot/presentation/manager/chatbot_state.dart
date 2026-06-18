part of 'chatbot_cubit.dart';

abstract class ChatbotState extends Equatable {
  final List<ChatMessageItem> messages;
  final bool isSending;

  const ChatbotState({required this.messages, this.isSending = false});

  @override
  List<Object?> get props => [messages, isSending];
}

/// Empty conversation — only the welcome card is shown.
class ChatbotInitial extends ChatbotState {
  const ChatbotInitial() : super(messages: const []);
}

/// Normal state — conversation in progress. [isSending] drives the
/// typing-indicator bubble while waiting for a bot reply.
class ChatbotUpdated extends ChatbotState {
  const ChatbotUpdated({required super.messages, super.isSending = false});
}

/// A message failed to send. The failed user message stays in [messages]
/// so the UI can offer a retry.
class ChatbotError extends ChatbotState {
  final String errMessage;

  const ChatbotError({
    required super.messages,
    required this.errMessage,
    super.isSending = false,
  });

  @override
  List<Object?> get props => [messages, isSending, errMessage];
}