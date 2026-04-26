import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_match/core/networking/chat_service.dart';
import 'package:stay_match/core/utils/service_locator.dart';

import '../../data/repos/chat_repo_impl.dart';
import '../manager/message_cubit.dart';
import '../widgets/messages_view/message_input_bar.dart';
import '../widgets/messages_view/messages_view_body.dart';

// --- 1. Main View Entry Point ---
class MessagesView extends StatelessWidget {
  final String otherUserId;

  const MessagesView({super.key, required this.otherUserId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessageCubit(
        chatRepo: getIt.get<ChatRepoImpl>(),
        chatService: getIt.get<ChatService>(),
        otherUserId: otherUserId,
      )..startChat(otherUserId: otherUserId),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: const MessagesViewBody(),
            resizeToAvoidBottomInset: true,
            bottomNavigationBar: MessageInputBar(
              chatId: BlocProvider.of<MessageCubit>(context).chatId ?? -1,
            ),
          );
        }
      ),
    );
  }
}