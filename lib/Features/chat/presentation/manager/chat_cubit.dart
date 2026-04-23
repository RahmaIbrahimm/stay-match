import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:stay_match/Features/chat/data/models/my_chats.dart';
import 'package:stay_match/Features/chat/data/repos/chat_repo.dart';

part 'chat_state.dart';

//
// class ChatCubit extends Cubit<ChatState> {
//   ChatRepo chatRepo;
//
//   ChatCubit({required this.chatRepo}) : super(ChatInitial());
//
//   Future<void> getAllChats() async {
//     emit(ChatLoading());
//     log('chats loading');
//     var response = await chatRepo.getMyChats();
//     response.fold((fail) => emit(ChatFailure(errMessage: fail.errMessage)), (
//       response,
//     ) {
//       if (response.isSuccess == true) {
//         log('emit chat success');
//         emit(ChatSuccess(response: response));
//       } else {
//         emit(
//           ChatFailure(errMessage: response.message ?? 'Error getting chats'),
//         );
//         log('emit chat fail');
//       }
//     });
//   }
// }

class ChatCubit extends Cubit<ChatState> {
  final ChatRepo chatRepo;
  final HubConnection hubConnection;

  ChatCubit({required this.chatRepo, required this.hubConnection})
    : super(ChatInitial()) {
    _listenToChatListUpdates();
  }

  // ميثود لجلب الشاتات
  Future<void> getChats() async {
    emit(ChatLoading());
    var result = await chatRepo.getMyChats();
    result.fold(
      (failure) => emit(ChatFailure(errMessage: failure.errMessage)),
      (chats) {
        if (chats.isSuccess == true) {
        log('emit chat success');
        emit(ChatSuccess(response: chats));
      } else {
        emit(
          ChatFailure(errMessage: chats.message ?? 'Error getting chats'),
        );
        log('emit chat fail');
      }
      },
    );
  }

  // الاستماع للتحديثات اللحظية للقائمة
  void _listenToChatListUpdates() {
    hubConnection.on("RefreshChatList", (arguments) {
      // أول ما يجيلنا الإشعار ده، بنحدث القائمة فوراً عشان الرسالة الأخيرة تظهر
      getChats();
    });
  }
}