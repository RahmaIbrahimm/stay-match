part of 'message_cubit.dart';

abstract class MessageState extends Equatable {
  const MessageState();
  @override
  List<Object?> get props => [];
}

class MessageInitial extends MessageState {}
class MessageLoading extends MessageState {}
class MessageFailure extends MessageState {
  final String errMessage;
  const MessageFailure({required this.errMessage});
}

class MessageSuccess extends MessageState {
  final List<Messages> messages;
  final int? chatId;
  final String? otherUserName;
  final String? otherUserProfile;

  // New fields for the "Staged" file
  final String? stagedFileName;
  final String? stagedFileBase64;

  const MessageSuccess({
    required this.messages,
    this.chatId,
    this.otherUserName,
    this.otherUserProfile,
    this.stagedFileName,
    this.stagedFileBase64,
  });

  MessageSuccess copyWith({
    List<Messages>? messages,
    int? chatId,
    String? otherUserName,
    String? otherUserProfile,
    String? stagedFileName,
    String? stagedFileBase64,
    bool clearFile = false, // Helper to remove the file from state
  }) {
    return MessageSuccess(
      messages: messages ?? this.messages,
      chatId: chatId ?? this.chatId,
      otherUserName: otherUserName ?? this.otherUserName,
      otherUserProfile: otherUserProfile ?? this.otherUserProfile,
      stagedFileName: clearFile ? null : (stagedFileName ?? this.stagedFileName),
      stagedFileBase64: clearFile ? null : (stagedFileBase64 ?? this.stagedFileBase64),
    );
  }

  @override
  List<Object?> get props => [
    messages,
    chatId,
    otherUserName,
    otherUserProfile,
    stagedFileName,
    stagedFileBase64
  ];
}
class MessageSentFailure extends MessageState {
  final String errMessage;
  const MessageSentFailure({required this.errMessage});
}
class MessageSentSuccess extends MessageState {
  final String message;
  const MessageSentSuccess({
    required this.message});
  @override
  List<Object?> get props => [message];
 }