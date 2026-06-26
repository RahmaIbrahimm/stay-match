part of 'chat_list_cubit.dart';

@immutable
sealed class ChatListState extends Equatable {}

final class ChatInitial extends ChatListState {
  @override
  List<Object?> get props => [];
}
final class ChatLoading extends ChatListState {
  @override
  List<Object?> get props => [];
}
class ChatSuccess extends ChatListState {
  final MyChats? response;
  final SearchChatsResponse? searchResponse;
  final bool isSearching; // New tracking property

   ChatSuccess({
    this.response,
    this.searchResponse,
    this.isSearching = false,
  });

  bool get isSearchMode => searchResponse != null;

  ChatSuccess copyWith({
    MyChats? response,
    SearchChatsResponse? searchResponse,
    bool? isSearching,
  }) {
    return ChatSuccess(
      response: response ?? this.response,
      searchResponse: searchResponse ?? this.searchResponse,
      isSearching: isSearching ?? this.isSearching,
    );
  }

  @override
  List<Object?> get props =>[response, searchResponse, isSearching];
}final class ChatFailure extends ChatListState {
  final String errMessage;

  ChatFailure({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}