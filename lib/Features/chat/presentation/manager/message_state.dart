// part of 'message_cubit.dart';
//
// @immutable
// sealed class MessageState extends Equatable {}
//
// final class MessageInitial extends MessageState {
//   @override
//   List<Object?> get props => [];
// }
//
// final class MessageLoading extends MessageState {
//   @override
//   List<Object?> get props => [];
// }
//
// class MessageSuccess extends MessageState {
//   final List<Messages> messages; // قائمة الرسائل من موديل StartChat
//   final int? chatId;
//   final String? otherUserName;
//   final String? otherUserProfile;
//
//   MessageSuccess({
//     required this.messages,
//     this.chatId,
//     this.otherUserName,
//     this.otherUserProfile,
//   });
//
//   @override
//   // TODO: implement props
//   List<Object?> get props => [
//     messages,
//     chatId,
//     otherUserName,
//     otherUserProfile,
//   ];
// }
//
// final class MessageFailure extends MessageState {
//   final String errMessage;
//
//   MessageFailure({required this.errMessage});
//
//   @override
//   List<Object?> get props => [errMessage];
// }