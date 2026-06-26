import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:stay_match/core/networking/chat_service.dart';

import '../../data/models/start_chat_response.dart';
import '../../data/repos/chat_repo.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  final ChatRepo chatRepo;
  final ChatService chatService;
  final String otherUserId;
   String? myUserId;

  bool _isServiceStarted = false;
  int? _chatId;
  final AudioRecorder _audioRecorder = AudioRecorder();

  int? get chatId => _chatId;

  MessageCubit({
    required this.chatRepo,
    required this.chatService,
    required this.otherUserId,
    this.myUserId,
  }) : super(MessageInitial()) {
    log("🛠️ [MessageCubit] Initialized for: $otherUserId");
  }

  // --- 1. START CHAT & REFRESH LOGIC ---
  Future<void> startChat({required String otherUserId, bool isRefresh = false}) async {
    if (state is! MessageSuccess && !isRefresh) {
      emit(MessageLoading());
    }

    var result = await chatRepo.startChat(otherUserId: otherUserId);

    result.fold(
          (failure) {
        log("❌ [startChat] Error: ${failure.errMessage}");
        if (!isRefresh) emit(MessageFailure(errMessage: failure.errMessage));
      },
          (response) {
        final chatData = response.data;
        final messagesList = List<Messages>.from(chatData?.messages ?? []);
        _chatId = chatData?.chatId;

        if (!isClosed) {
          if (isRefresh && state is MessageSuccess) {
            final currentState = state as MessageSuccess;
            // On refresh, replace only real messages — keep any still-pending
            // optimistic ones (id == -1) that haven't been confirmed yet
            final pendingOptimistic = currentState.messages
                .where((m) => m.id == -1)
                .toList();
            emit(currentState.copyWith(
              messages: [...messagesList, ...pendingOptimistic],
            ));
          } else {
            emit(MessageSuccess(
              messages: messagesList,
              chatId: chatData?.chatId,
              otherUserName: chatData?.otherUserFullName,
              otherUserProfile: chatData?.otherUserProfilePicture,
            ));
          }
        }

        if (!_isServiceStarted) {
          _isServiceStarted = true;
          log("📡 [SignalR] Initializing Hub Connection...");
          chatService.initHub(
            onRefresh: () {
              log("🔄 [SignalR] Event Received: Refreshing chat...");
              startChat(otherUserId: otherUserId, isRefresh: true);
            },
          );
        }
      },
    );
  }

  // --- 2. VOICE RECORDING LOGIC ---
  Future<void> startRecording() async {
    try {
      log("🎙️ [Voice] Checking microphone permissions...");
      if (await _audioRecorder.hasPermission()) {
        final directory = await getApplicationDocumentsDirectory();
        final String filePath =
            '${directory.path}/voice_${DateTime.now().millisecondsSinceEpoch}.m4a';
        log("🎙️ [Voice] Recording started: $filePath");
        await _audioRecorder.start(const RecordConfig(), path: filePath);
      } else {
        log("⚠️ [Voice] Permission denied by user");
      }
    } catch (e) {
      log("❌ [Voice] Start Error: $e");
    }
  }

  Future<void> discardRecording() async {
    try {
      await _audioRecorder.stop();
      log("🗑️ [Voice] Recording discarded locally.");
    } catch (e) {
      log("❌ [Voice] Discard Error: $e");
    }
  }

  Future<void> stopAndSendRecording() async {
    try {
      final String? path = await _audioRecorder.stop();
      if (path != null && _chatId != null) {
        log("✅ [Voice] Record stopped. Sending file at: $path");

        var result = await chatRepo.sendMessage(
          chatId: _chatId!,
          filePath: path,
          type: "Voice",
        );

        result.fold(
              (failure) => log("❌ [Voice] Send API Error: ${failure.errMessage}"),
              (success) => log("✨ [Voice] Message Sent Successfully"),
        );
      }
    } catch (e) {
      log("❌ [Voice] Stop/Send Error: $e");
    }
  }

  // --- 3. FILE PICKING LOGIC ---
  Future<void> pickAFile() async {
    try {
      log("🔵 [FilePicker] Opening picker...");
      FilePickerResult? result = await FilePicker.pickFiles();

      if (result != null && result.files.single.path != null) {
        String filePath = result.files.single.path!;
        String fileName = result.files.single.name;

        if (state is MessageSuccess) {
          emit((state as MessageSuccess).copyWith(
            stagedFileName: fileName,
            stagedFileBase64: filePath,
          ));
          log("✅ [FilePicker] Staged: $fileName");
        }
      }
    } catch (e) {
      log("❌ [FilePicker] Error: $e");
    }
  }

  // --- 4. MAIN SEND MESSAGE (Text, Image, or File) ---
  Future<void> handleSendMessage({String? text}) async {
    if (state is! MessageSuccess || _chatId == null) return;

    final currentState = state as MessageSuccess;
    final String? path = currentState.stagedFileBase64;
    final String? fileName = currentState.stagedFileName;

    final bool hasText = text != null && text.trim().isNotEmpty;
    final bool hasFile = path != null;
    if (!hasText && !hasFile) return;

    // Determine type
    String apiType = "Text";
    if (hasFile) {
      apiType = _isImage(fileName) ? "Image" : "File";
    }

    // Build optimistic message — shown immediately before API responds
    final optimisticMessage = Messages(
      id: -1,
      content: hasText ? text : fileName,
      senderId: myUserId ?? '',
      sentAt: DateTime.now().toIso8601String(),
      type: apiType,
      fileUrl: path,
    );

    // Insert optimistic message and clear staged file right away
    emit(currentState.copyWith(
      messages: [...currentState.messages, optimisticMessage],
      clearFile: true,
    ));

    log("🚀 [SendMessage] Sending $apiType...");

    var result = await chatRepo.sendMessage(
      chatId: _chatId!,
      content: hasText ? text : null,
      filePath: path,
      type: apiType,
    );

    // State may have changed while awaiting — grab the latest
    if (state is! MessageSuccess) return;
    final afterSendState = state as MessageSuccess;

    result.fold(
          (failure) {
        log("❌ [SendMessage] Error: ${failure.errMessage}");
        // Mark the optimistic message as failed by moving id -1 to failedMessageIds.
        // We use the content as key since we have no real ID yet.
        final failKey = hasText ? (text ?? 'file') : (fileName ?? 'file');
        emit(afterSendState.copyWith(
          failedMessageIds: {...afterSendState.failedMessageIds, failKey},
        ));
      },
          (success) {
        log("✨ [SendMessage] Success");
        // Remove the optimistic message — SignalR refresh will bring the real one
        final withoutOptimistic = afterSendState.messages
            .where((m) => m.id != -1)
            .toList();
        emit(afterSendState.copyWith(messages: withoutOptimistic));
      },
    );
  }
  Future<void> retrySendMessage(Messages failedMessage) async {
    if (state is! MessageSuccess || _chatId == null) return;
    final currentState = state as MessageSuccess;

    final failKey = failedMessage.content ?? 'file';

    // Remove from failed, mark as pending again
    emit(currentState.copyWith(
      failedMessageIds: currentState.failedMessageIds
          .where((id) => id != failKey)
          .toSet(),
    ));

    final String? path = failedMessage.fileUrl;
    String apiType = failedMessage.type ?? "Text";

    var result = await chatRepo.sendMessage(
      chatId: _chatId!,
      content: failedMessage.content,
      filePath: path,
      type: apiType,
    );

    if (state is! MessageSuccess) return;
    final afterState = state as MessageSuccess;

    result.fold(
          (failure) {
        log("❌ [Retry] Failed again: ${failure.errMessage}");
        // Put it back in failed
        emit(afterState.copyWith(
          failedMessageIds: {...afterState.failedMessageIds, failKey},
        ));
      },
          (success) {
        log("✨ [Retry] Success");
        // Remove the optimistic message — SignalR will bring the real one
        final withoutOptimistic = afterState.messages
            .where((m) => m.id != -1)
            .toList();
        emit(afterState.copyWith(messages: withoutOptimistic));
      },
    );
  }
  void deleteFailedMessage(Messages failedMessage) {
    if (state is! MessageSuccess) return;
    final currentState = state as MessageSuccess;
    final failKey = failedMessage.content ?? 'file';

    emit(currentState.copyWith(
      messages: currentState.messages
          .where((m) => !(m.id == -1 && m.content == failedMessage.content))
          .toList(),
      failedMessageIds: currentState.failedMessageIds
          .where((id) => id != failKey)
          .toSet(),
    ));
  }
  // --- HELPERS ---
  bool _isImage(String? fileName) {
    if (fileName == null) return false;
    final imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.webp'];
    return imageExtensions.any((ext) => fileName.toLowerCase().endsWith(ext));
  }

  void clearStagedFile() {
    if (state is MessageSuccess) {
      emit((state as MessageSuccess).copyWith(clearFile: true));
    }
  }

  @override
  Future<void> close() {
    log("⚰️ [MessageCubit] Disposing resources...");
    _audioRecorder.dispose();
    chatService.hubConnection.off('ReceiveMessage');
    return super.close();
  }
}