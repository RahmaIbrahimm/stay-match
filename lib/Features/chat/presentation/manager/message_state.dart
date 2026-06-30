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

class MessageSending extends MessageState {}

class MessageSuccess extends MessageState {
  final List<Messages> messages;
  final int? chatId;
  final String? otherUserName;
  final String? otherUserProfile;
  final String? stagedFileName;
  final String? stagedFileBase64;
  final Set<String> pendingMessageIds;
  final Set<String> failedMessageIds;

  const MessageSuccess({
    required this.messages,
    this.chatId,
    this.otherUserName,
    this.otherUserProfile,
    this.stagedFileName,
    this.stagedFileBase64,
    this.pendingMessageIds = const {},
    this.failedMessageIds = const {},
  });

  MessageSuccess copyWith({
    List<Messages>? messages,
    int? chatId,
    String? otherUserName,
    String? otherUserProfile,
    String? stagedFileName,
    String? stagedFileBase64,
    bool clearFile = false,
    Set<String>? pendingMessageIds,
    Set<String>? failedMessageIds,
  }) {
    return MessageSuccess(
      messages: messages ?? this.messages,
      chatId: chatId ?? this.chatId,
      otherUserName: otherUserName ?? this.otherUserName,
      otherUserProfile: otherUserProfile ?? this.otherUserProfile,
      stagedFileName: clearFile ? null : (stagedFileName ?? this.stagedFileName),
      stagedFileBase64: clearFile ? null : (stagedFileBase64 ?? this.stagedFileBase64),
      pendingMessageIds: pendingMessageIds ?? this.pendingMessageIds,
      failedMessageIds: failedMessageIds ?? this.failedMessageIds,
    );
  }

  @override
  List<Object?> get props => [
    messages,
    chatId,
    otherUserName,
    otherUserProfile,
    stagedFileName,
    stagedFileBase64,
    pendingMessageIds,
    failedMessageIds,
  ];
}

class MessageSentFailure extends MessageState {
  final String errMessage;
  const MessageSentFailure({required this.errMessage});
}

class MessageSentSuccess extends MessageState {
  final String message;
  const MessageSentSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}