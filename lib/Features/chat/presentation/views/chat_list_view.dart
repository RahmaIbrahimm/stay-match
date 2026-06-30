import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_match/Features/chat/data/repos/chat_repo_impl.dart';
import 'package:stay_match/Features/chat/presentation/manager/chat_list_cubit.dart';
import 'package:stay_match/core/networking/chat_service.dart';
import 'package:stay_match/core/utils/service_locator.dart';
import 'package:stay_match/core/widgets/app_drawer/main_app_drawer.dart';

import '../../../../core/widgets/draggable_chatbot_fab.dart';
import '../widgets/chat_list_view/chat_list_body.dart';

class ChatListView extends StatelessWidget {
  const ChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ChatListCubit(getIt.get<ChatRepoImpl>(), getIt.get<ChatService>())
            ..getInbox(),
      child: Scaffold(
        endDrawer: MainAppDrawer(),
        body: Builder(
          builder: (innerContext) {
            return RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<ChatListCubit>(innerContext).getInbox();
              },
              child: ChatListBody(),
            );
          }
        ),
      ),
    );
  }
}