// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:stay_match/Features/chat/data/repos/chat_repo_impl.dart';
// import 'package:stay_match/Features/chat/presentation/manager/chat_cubit.dart';
// import 'package:stay_match/core/constants/app_colors.dart';
// import 'package:stay_match/core/constants/app_strings.dart';
// import 'package:stay_match/core/constants/app_styles.dart';
// import 'package:stay_match/core/utils/service_locator.dart';
//
// import '../widgets/chat_list_view/chat_list_view_body.dart';
//
// class ChatListView extends StatelessWidget {
//   const ChatListView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) =>
//           ChatCubit(chatRepo: getIt.get<ChatRepoImpl>(), hubConnection: null)..getAllChats(),
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: AppColors.containerColor,
//           title: Text(AppStrings.chats, style: AppStyles.bold24poppins),
//         ),
//         body: ChatListViewBody(),
//       ),
//     );
//   }
// }