// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:stay_match/Features/chat/data/repos/chat_repo.dart';
// import 'package:stay_match/core/utils/service_locator.dart';
//
// import '../../data/repos/chat_repo_impl.dart';
// import '../manager/message_cubit.dart';
// import '../widgets/messages_view/messages_view_body.dart';
//
// class MessagesView extends StatefulWidget {
//   final String otherUserId;
//
//   const MessagesView({super.key, required this.otherUserId});
//
//   @override
//   State<MessagesView> createState() => _MessagesViewState();
// }
//
// class _MessagesViewState extends State<MessagesView> {
//   @override
//   void initState() {
//     super.initState();
//     // أول ما نفتح، بننادي الـ startChat عشان نجيب القديم ونفتح الـ SignalR
//     context.read<MessageCubit>().startChat(otherUserId: widget.otherUserId);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => MessageCubit(chatRepo: getIt.get<ChatRepoImpl>(), hubConnection: hubConnection),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Chat"), // ممكن تجيب الاسم من الـ State لاحقاً
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back_ios),
//             onPressed: () => context.pop(),
//           ),
//         ),
//         body: const MessagesViewBody(),
//       ),
//     );
//   }
// }