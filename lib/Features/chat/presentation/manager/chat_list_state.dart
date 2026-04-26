part of 'chat_list_cubit.dart';

@immutable
sealed class ChatListState extends Equatable {}

final class ChatInitial extends ChatListState {
  @override
  List<Object?> get props => [];
}
final class ChatlLoading extends ChatListState {
  @override
  List<Object?> get props => [];
}
final class ChatSuccess extends ChatListState {
  final MyChats response;

  ChatSuccess({required this.response});

  @override
  List<Object?> get props => [response];
}
final class ChatFailure extends ChatListState {
  final String errMessage;

  ChatFailure({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}