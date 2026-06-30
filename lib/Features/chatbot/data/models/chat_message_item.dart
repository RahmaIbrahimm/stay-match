import 'package:equatable/equatable.dart';
import 'package:stay_match/Features/chatbot/data/models/chatbot_response.dart';

enum ChatSender { user, bot }

/// A single entry in the chatbot conversation, built from either a locally
/// typed user message or a [ChatbotResponse] from the bot.
class ChatMessageItem extends Equatable {
  final ChatSender sender;
  final String? text;
  final DateTime timestamp;
  final List<Suggestions> suggestions;
  final List<Results> results;
  final Pagination? pagination;

  const ChatMessageItem({
    required this.sender,
    required this.timestamp,
    this.text,
    this.suggestions = const [],
    this.results = const [],
    this.pagination,
  });

  @override
  List<Object?> get props =>
      [sender, text, timestamp, suggestions, results, pagination];
}