// import 'dart:developer';
// import 'dart:io';
//
// import 'package:equatable/equatable.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:path_provider/path_provider.dart'; // Add this
// import 'package:record/record.dart'; // Add this
// import 'package:stay_match/core/networking/chat_service.dart';
//
// import '../../data/models/start_chat_response.dart';
// import '../../data/repos/chat_repo.dart';
//
// part 'message_state.dart';
//
// class MessageCubit extends Cubit<MessageState> {
//   final ChatRepo chatRepo;
//   final ChatService chatService;
//   bool _isServiceStarted = false;
//   final String otherUserId;
//   int? _chatId;
//
//   // Voice Recording Instance
//   final AudioRecorder _audioRecorder = AudioRecorder();
//
//   int? get chatId => _chatId;
//
//   MessageCubit({
//     required this.chatRepo,
//     required this.chatService,
//     required this.otherUserId,
//   }) : super(MessageInitial());
//
//   // --- 1. Voice Recording Logic ---
//
//   Future<void> startRecording() async {
//     try {
//       log("🎙️ [Voice] Checking permissions...");
//       if (await _audioRecorder.hasPermission()) {
//         final directory = await getApplicationDocumentsDirectory();
//         // Create unique path for the audio file
//         final String filePath =
//             '${directory.path}/voice_${DateTime.now().millisecondsSinceEpoch}.m4a';
//
//         log("🎙️ [Voice] Starting record at: $filePath");
//         await _audioRecorder.start(const RecordConfig(), path: filePath);
//       } else {
//         log("❌ [Voice] Permission denied");
//       }
//     } catch (e) {
//       log("❌ [Voice] Start Error: $e");
//     }
//   }
//
//   Future<void> stopAndSendRecording() async {
//     try {
//       final String? path = await _audioRecorder.stop();
//       if (path != null && _chatId != null) {
//         log("✅ [Voice] Record stopped. Path: $path. Sending...");
//
//         // Directly call the repo with the "Audio" type
//         var result = await chatRepo.sendMessage(
//           chatId: _chatId!,
//           filePath: path,
//           type: "Voice",
//         );
//
//         result.fold(
//               (failure) => log("❌ [Voice] Send Failure: ${failure.errMessage}"),
//               (success) => log("✨ [Voice] Voice Message Sent Successfully"),
//         );
//       }
//     } catch (e) {
//       log("❌ [Voice] Stop Error: $e");
//     }
//   }
//
//   // --- 2. Pick File Logic ---
//
//   Future<void> pickAFile() async {
//     try {
//       FilePickerResult? result = await FilePicker.pickFiles();
//
//       if (result != null && result.files.single.path != null) {
//         String filePath = result.files.single.path!;
//         String fileName = result.files.single.name;
//
//         if (state is MessageSuccess) {
//           emit((state as MessageSuccess).copyWith(
//             stagedFileName: fileName,
//             stagedFileBase64: filePath,
//           ));
//         }
//       }
//     } catch (e) {
//       log("❌ [pickAFile] Error: $e");
//     }
//   }
//
//   // --- 3. Start Chat Logic ---
//
//   Future<void> startChat({required String otherUserId}) async {
//     if (state is! MessageSuccess) {
//       emit(MessageLoading());
//     }
//
//     var result = await chatRepo.startChat(otherUserId: otherUserId);
//     result.fold(
//           (failure) => emit(MessageFailure(errMessage: failure.errMessage)),
//           (response) {
//         final chatData = response.data;
//         final messagesList = List<Messages>.from(chatData?.messages ?? []);
//         _chatId = chatData?.chatId;
//
//         if (!isClosed) {
//           emit(MessageSuccess(
//             messages: messagesList,
//             chatId: chatData?.chatId,
//             otherUserName: chatData?.otherUserFullName,
//             otherUserProfile: chatData?.otherUserProfilePicture,
//           ));
//         }
//
//         if (!_isServiceStarted) {
//           _isServiceStarted = true;
//           chatService.initHub(
//             onRefresh: () => startChat(otherUserId: otherUserId),
//           );
//         }
//       },
//     );
//   }
//
//   // --- 4. Main Send Logic (Text/Image/File) ---
//
//   Future<void> handleSendMessage({String? text}) async {
//     if (state is! MessageSuccess) return;
//
//     final currentState = state as MessageSuccess;
//     final String? path = currentState.stagedFileBase64;
//     final String? fileName = currentState.stagedFileName;
//
//     String apiType = "Text";
//     if (path != null) {
//       apiType = _isImage(fileName) ? "Image" : "File";
//     }
//
//     var result = await chatRepo.sendMessage(
//       chatId: _chatId!,
//       content: text,
//       filePath: path,
//       type: apiType,
//     );
//
//     result.fold(
//           (failure) => log("❌ [handleSendMessage] Error: ${failure.errMessage}"),
//           (success) {
//         emit(currentState.copyWith(
//           stagedFileName: null,
//           stagedFileBase64: null,
//         ));
//       },
//     );
//   }
//
//   bool _isImage(String? fileName) {
//     if (fileName == null) return false;
//     final images = ['.jpg', '.jpeg', '.png', '.gif', '.webp'];
//     return images.any((ext) => fileName.toLowerCase().endsWith(ext));
//   }
//
//   @override
//   Future<void> close() {
//     _audioRecorder.dispose(); // Dispose the recorder
//     chatService.hubConnection.off('ReceiveMessage');
//     return super.close();
//   }
// }
import 'dart:developer';
import 'dart:io';

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

  bool _isServiceStarted = false;
  int? _chatId;
  final AudioRecorder _audioRecorder = AudioRecorder();

  int? get chatId => _chatId;

  MessageCubit({
    required this.chatRepo,
    required this.chatService,
    required this.otherUserId,
  }) : super(MessageInitial()) {
    log("🛠️ [MessageCubit] Initialized for: $otherUserId");
  }

  // --- 1. START CHAT & REFRESH LOGIC ---
  // isRefresh: If true, fetches data without emitting MessageLoading()
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
            // Update only the message list to keep staged files/previews intact
            final currentState = state as MessageSuccess;
            emit(currentState.copyWith(messages: messagesList));
          } else {
            emit(MessageSuccess(
              messages: messagesList,
              chatId: chatData?.chatId,
              otherUserName: chatData?.otherUserFullName,
              otherUserProfile: chatData?.otherUserProfilePicture,
            ));
          }
        }

        // Initialize SignalR only once
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
        final String filePath = '${directory.path}/voice_${DateTime.now().millisecondsSinceEpoch}.m4a';

        log("🎙️ [Voice] Recording started: $filePath");
        await _audioRecorder.start(const RecordConfig(), path: filePath);
      } else {
        log("⚠️ [Voice] Permission denied by user");
      }
    } catch (e) {
      log("❌ [Voice] Start Error: $e");
    }
  }
// Add this inside your MessageCubit class
  Future<void> discardRecording() async {
    try {
      // This stops the recorder but we ignore the returned path
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
            stagedFileBase64: filePath, // Storing the path for Multipart
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

    // Logic to determine API type
    String apiType = "Text";
    if (path != null) {
      apiType = _isImage(fileName) ? "Image" : "File";
    }

    log("🚀 [SendMessage] Sending $apiType...");

    var result = await chatRepo.sendMessage(
      chatId: _chatId!,
      content: text,
      filePath: path,
      type: apiType,
    );

    result.fold(
          (failure) => log("❌ [SendMessage] Error: ${failure.errMessage}"),
          (success) {
        log("✨ [SendMessage] Success");
        // Reset staged files after successful send
        emit(currentState.copyWith(
          stagedFileName: null,
          stagedFileBase64: null,
        ));
      },
    );
  }

  // --- HELPERS ---
  bool _isImage(String? fileName) {
    if (fileName == null) return false;
    final imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.webp'];
    return imageExtensions.any((ext) => fileName.toLowerCase().endsWith(ext));
  }

  @override
  Future<void> close() {
    log("⚰️ [MessageCubit] Disposing resources...");
    _audioRecorder.dispose();
    chatService.hubConnection.off('ReceiveMessage');
    return super.close();
  }
}