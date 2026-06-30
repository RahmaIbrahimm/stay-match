import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_match/Features/other_user_profile/data/repos/other_user_profile_repo_impl.dart';
import 'package:stay_match/core/utils/service_locator.dart';
import 'package:stay_match/core/widgets/draggable_chatbot_fab.dart';

import '../manager/other_user_profile_cubit.dart';
import '../widgets/other_user_profile_body.dart';

class OtherUserProfileView extends StatelessWidget {
  final String userId;

  const OtherUserProfileView({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtherUserProfileCubit(
        otherUserProfileRepo: getIt.get<OtherUserProfileRepoImpl>(),
      )..getOtherUserProfile(userId: userId),
      child: DraggableChatbotFab(hasBottomNav: false,
      child: const OtherUserProfileBody()),
    );
  }
}