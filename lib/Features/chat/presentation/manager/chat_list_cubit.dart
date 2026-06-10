import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:stay_match/Features/chat/data/models/search_chats_response.dart';

import '../../../../core/networking/chat_service.dart';
import '../../data/models/my_chats.dart';
import '../../data/repos/chat_repo.dart';

part 'chat_list_state.dart';

class ChatListCubit extends Cubit<ChatListState> {
  final ChatRepo _chatRepo;
  final ChatService _chatService;
  bool _isServiceStarted = false;

  // Keep track of the current search string

  ChatListCubit(this._chatRepo, this._chatService) : super(ChatInitial());

  // Unified method to handle both Search and Full Fetch
// Inside ChatListCubit
  Future<void> getInbox({String? query}) async {
    final searchQuery = query ?? '';
    emit(ChatLoading());
    // Logic: If search is active, call search API, otherwise call normal API
    final result = searchQuery.isEmpty
        ? await _chatRepo.getMyChats()
        : await _chatRepo.searchChats(search: searchQuery);

    result.fold(
          (failure) => emit(ChatFailure(errMessage: failure.errMessage)),
          (response) {
        if (searchQuery.isEmpty) {
          // Path A: 'response' is already MyChats
          emit(ChatSuccess(response: response as MyChats));
        } else {
          // Path B: 'response' is the search model list
          // Manually build a MyChats object from the search results
          emit(ChatSuccess(searchResponse: response as SearchChatsResponse));
        }
           if (!_isServiceStarted) {
          _isServiceStarted = true;
          _chatService.initHub(onRefresh: () => getInbox());
        }
      },
    );
  }
  @override
  Future<void> close() {
    _chatService.stopHub();
    return super.close();
  }
}



// class ChatListCubit extends Cubit<ChatListState> {
//   final ChatRepo _chatRepo;
//   final ChatService _chatService;
//   bool _isServiceStarted = false;
//   String _search = '';
//   String get search => _search;
//   ChatListCubit(this._chatRepo, this._chatService) : super(ChatInitial());
//
//   Future<void> getInbox() async {
//     // 1. Only show the full-screen spinner if the list is currently empty
//     if (state is! ChatSuccess) {
//       emit(ChatlLoading());
//     }
//
//     // 2. Fetch the data in the background
//     final result = await _chatRepo.getMyChats();
//
//     result.fold(
//           (failure) {
//         // 3. If we already have data, maybe don't show an error screen?
//         // Just log it or show a SnackBar so the user doesn't lose their current view.
//         if (state is! ChatSuccess) {
//           emit(ChatFailure(errMessage: failure.errMessage));
//         }
//       },
//           (myChatsResponse) {
//         // 4. Emit success with the new data.
//         // Flutter will automatically compare the new list and update the UI smoothly.
//         emit(ChatSuccess(response: myChatsResponse));
//
//         // SignalR initialization logic...
//         if (!_isServiceStarted) {
//           _isServiceStarted = true;
//           _chatService.initHub(onRefresh: () => getInbox());
//         }
//       },
//     );
//   }
//   @override
//   Future<void> close() {
//     _chatService.stopHub();
//     return super.close();
//   }
// }