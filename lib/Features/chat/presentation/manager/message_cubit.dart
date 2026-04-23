// // import 'dart:developer';
// //
// // import 'package:bloc/bloc.dart';
// // import 'package:equatable/equatable.dart';
// // import 'package:meta/meta.dart';
// // import 'package:signalr_netcore/hub_connection.dart';
// // import 'package:stay_match/Features/chat/data/models/start_chat_response.dart';
// // import 'package:stay_match/Features/chat/data/repos/chat_repo.dart';
//
//
// // class MessageCubit extends Cubit<MessageState> {
// //   final ChatRepo chatRepo;
// //   final HubConnection hubConnection;
// //
// //   MessageCubit({required this.chatRepo, required this.hubConnection})
// //     : super(MessageInitial());
// //
// //   List<Messages> _chatMessages = [];
// //
// //   Future<void> startChat({required String otherUserId}) async {
// //     emit(MessageLoading());
// //     log('person message loading');
// //     var response = await chatRepo.startChat(otherUserId: otherUserId);
// //     response.fold((fail) => emit(MessageFailure(errMessage: fail.errMessage)), (
// //         res,
// //     ) {
// //       if (res.isSuccess == true) {
// //         log('emit message success for person');
// //         _chatMessages = res.data?.messages ?? [];
// //         _listenToSignalR();
// //         emit(MessageSuccess(
// //             messages: List.from(_chatMessages),
// //             chatId: res.data?.chatId
// //         ));
// //       } else {
// //         emit(
// //           MessageFailure(errMessage: res.message ?? 'Error getting chats'),
// //         );
// //         log('emit message fail for person');
// //       }
// //     });
// //   }
// //
// //   void _listenToSignalR() {
// //     // ركز هنا: "ReceiveMessage" لازم تكون مكتوبة زي الـ Backend بالظبط
// //     hubConnection.on("ReceiveMessage", (arguments) {
// //       if (arguments != null && arguments.isNotEmpty) {
// //         // تحويل البيانات اللي جاية من SignalR لـ Messages Object
// //         final newMessage = Messages.fromJson(arguments[0]);
// //
// //         // إضافة الرسالة الجديدة للقائمة الحالية
// //         _chatMessages.add(newMessage);
// //
// //         // إرسال الحالة الجديدة للـ UI عشان يضيف الـ Bubble الجديدة فوراً
// //         emit(MessageSuccess(messages: List.from(_chatMessages)));
// //       }
// //     });
// //   }
// //   @override
// //   Future<void> close() {
// //     hubConnection.off("ReceiveMessage");
// //     return super.close();
// //   }
// // }
// import 'dart:developer';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:signalr_netcore/signalr_client.dart';
// import '../../data/models/start_chat_response.dart';
// import '../../data/repos/chat_repo.dart';
// part 'message_state.dart';
//
// class MessageCubit extends Cubit<MessageState> {
//   final ChatRepo chatRepo;
//   // final HubConnection hubConnection;
//
//   MessageCubit({required this.chatRepo}) : super(MessageInitial());
//   // MessageCubit({required this.chatRepo, required this.hubConnection}) : super(MessageInitial());
//
//   // 1. تشغيل الشات (Start/Resume)
//   Future<void> startChat({required String otherUserId}) async {
//     emit(MessageLoading());
//     var result = await chatRepo.startChat(otherUserId: otherUserId);
//
//     result.fold(
//           (failure) => emit(MessageFailure(errMessage:  failure.errMessage)),
//           (response) {
//         final chatData = response.data;
//         final messagesList = chatData?.messages ?? [];
//
//         emit(MessageSuccess(
//           messages: messagesList,
//           chatId: chatData?.chatId,
//           otherUserName: chatData?.otherUserFullName,
//           otherUserProfile: chatData?.otherUserProfilePicture,
//         ));
//
//         // ربط الـ SignalR بالـ ChatId اللي رجع لاستقبال الرسائل
//         if (chatData?.chatId != null) {
//           _listenToMessages();
//         }
//       },
//     );
//   }
//
//   // 2. الاستماع للرسائل (SignalR Listener)
//   void _listenToMessages() {
//     hubConnection.off("ReceiveMessage");
//     hubConnection.on("ReceiveMessage", (arguments) {
//       if (arguments != null && state is MessageSuccess) {
//         final currentState = state as MessageSuccess;
//
//         // تحويل الـ JSON اللي جاي من السيرفر لموديل Messages
//         final newMessage = Messages.fromJson(arguments[0]);
//
//         // تحديث القائمة فوراً بإضافة الرسالة الجديدة
//         final updatedMessages = List<Messages>.from(currentState.messages)..add(newMessage);
//
//         emit(MessageSuccess(
//           messages: updatedMessages,
//           chatId: currentState.chatId,
//           otherUserName: currentState.otherUserName,
//           otherUserProfile: currentState.otherUserProfile,
//         ));
//       }
//     });
//   }
//
//   // 3. إرسال الرسالة (API POST)
//   Future<void> sendMessage({
//     required int chatId,
//     String? content,
//     String? filePath,
//     required String type,
//   }) async {
//     // نرسل الطلب، والرد هيجيلنا أوتوماتيك عبر SignalR في ميثود _listenToMessages
//     var result = await chatRepo.sendMessage(
//       chatId: chatId,
//       content: content,
//       filePath: filePath,
//       type: type,
//     );
//
//     result.fold(
//           (failure) => log("Error sending message: ${failure.errMessage}"),
//           (response) => log("API: Message sent successfully"),
//     );
//   }
//
//   @override
//   Future<void> close() {
//     hubConnection.off("ReceiveMessage"); // تنظيف الـ Listener عند إغلاق الشات
//     return super.close();
//   }
// }