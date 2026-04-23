part of 'chat_cubit.dart';

@immutable
sealed class ChatState extends Equatable {}

final class ChatInitial extends ChatState {
  @override
  List<Object?> get props => [];
}
final class ChatLoading extends ChatState {
  @override
  List<Object?> get props => [];
}
final class ChatSuccess extends ChatState {
  final MyChats response;

  ChatSuccess({required this.response});

  @override
  List<Object?> get props => [response];
}
final class ChatFailure extends ChatState {
  final String errMessage;

  ChatFailure({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}