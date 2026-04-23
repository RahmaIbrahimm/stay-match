// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:signalr_netcore/utils.dart';
//
// import '../../manager/message_cubit.dart';
//
// import 'package:flutter/material.dart';
//
// import 'chat_bubble.dart';
// import 'message_input_field.dart';
// class MessagesViewBody extends StatelessWidget {
//   const MessagesViewBody({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // ١. منطقة عرض الرسائل
//         Expanded(
//           child: BlocBuilder<MessageCubit, MessageState>(
//             builder: (context, state) {
//               if (state is MessageLoading) {
//                 return const Center(child: CircularProgressIndicator());
//               }
//
//               if (state is MessageSuccess) {
//                 final messages = state.messages;
//
//                 if (messages.isEmpty) {
//                   return const Center(child: Text("No messages yet. Say Hi!"));
//                 }
//
//                 return ListView.builder(
//                   reverse: true, // مهم جداً: الرسائل تبدأ من تحت
//                   padding: EdgeInsets.symmetric(vertical: 10.h),
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     // بنعرض الرسايل من الأحدث للأقدم بسبب الـ reverse
//                     final msg = messages.reversed.toList()[index];
//
//                     // تحديد لو الرسالة دي "مني" ولا "منه"
//                     // كلمة "You" بتيجي من الـ API بتاعكم للرسائل الخاصة بيك
//                     final bool isMe = msg.senderFullName == "You";
//
//                     return ChatBubble(message: msg, isMe: isMe);
//                   },
//                 );
//               }
//
//               if (state is MessageFailure) {
//                 return Center(child: Text(state.errMessage));
//               }
//
//               return const SizedBox.shrink();
//             },
//           ),
//         ),
//
//         // // ٢. منطقة الكتابة (Input Field)
//         // MessageInputField(
//         //   onSendMessage: (text) {
//         //     // هنا بننادي الـ Cubit عشان يبعت الرسالة
//         //     // الـ chatId ممكن تجيبه من الـ state.chatId في MessageSuccess
//         //     final state = context.read<MessageCubit>().state;
//         //     if (state is MessageSuccess && state.chatId != null) {
//         //       context.read<MessageCubit>().sendMessage(
//         //         chatId: state.chatId!,
//         //         content: text,
//         //       );
//         //     }
//         //   },
//         //   // onAttachFile: () {
//         //   //   // منطق اختيار الصور
//         //   // },
//         // ),
//       ],
//     );
//   }
// }