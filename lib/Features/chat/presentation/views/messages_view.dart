import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_match/core/networking/chat_service.dart';
import 'package:stay_match/core/utils/secure_storage_helper.dart';
import 'package:stay_match/core/utils/service_locator.dart';

import '../../../../core/utils/secure_storage_keys.dart';
import '../../data/repos/chat_repo_impl.dart';
import '../manager/message_cubit.dart';
import '../widgets/messages_view/message_input_bar.dart';
import '../widgets/messages_view/messages_view_body.dart';

class MessagesView extends StatefulWidget {
  final String otherUserId;

  const MessagesView({super.key, required this.otherUserId});

  @override
  State<MessagesView> createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  late final MessageCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = MessageCubit(
      chatRepo: getIt.get<ChatRepoImpl>(),
      chatService: getIt.get<ChatService>(),
      otherUserId: widget.otherUserId,
    )..startChat(otherUserId: widget.otherUserId);

    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final value = await getIt
        .get<SecureStorageHelper>()
        .readFromSecureStorage(key: SecureStorageKeys.userIdKey);
    if (mounted) {
      // Set it on the cubit so optimistic messages use the exact same value
      _cubit.myUserId = value;
    }
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(

        body: Column(
          children: [
            Expanded(child: const MessagesViewBody()),
            MessageInputBar(
              chatId: _cubit.chatId ?? -1,
            ),
          ],
        ),
        resizeToAvoidBottomInset: true,

      ),
    );
  }
}