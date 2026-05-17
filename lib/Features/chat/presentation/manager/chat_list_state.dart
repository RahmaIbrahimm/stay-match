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
final class ChatSuccess extends ChatListState {
  final MyChats? response;
  final SearchChatsResponse? searchResponse;

  ChatSuccess({this.searchResponse, this.response});

  // Helper to determine which data source to use
  bool get isSearchMode => searchResponse != null;

  @override
  List<Object?> get props => [response, searchResponse];
}
final class ChatFailure extends ChatListState {
  final String errMessage;

  ChatFailure({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}